class Meeting < ApplicationRecord
  # belongs_to :organization
  acts_as_tenant(:organization)
  has_many :user_meetings, dependent: :destroy
  has_many :users, through: :user_meetings

  validates :title, presence: true, uniqueness: true, length: { minimum: 2, maximum: 20}
  validates :scheduled_date, presence: true

  def save_zoom_meeting
    return if zoom_link.present?
    _zoom_link, _zoom_id = create_zoom_meeting(self.title, self.body, self.scheduled_date)
    update(zoom_link: _zoom_link, zoom_id: _zoom_id)
  end

  def create_zoom_meeting(topic, agenda, start_time)
    response = zoom_client.meeting_create(topic: topic, agenda: agenda,
                                          user_id: Rails.application.credentials.zoom[:user_id],
                                          settings: {join_before_host: true},
                                          start_time: start_time.strftime('%Y-%m-%dT%H:%M:%S'))
    [response['join_url'], response['id']]
  end

  def update_zoom_meeting
    zoom_client.meeting_update(meeting_id: self.zoom_id, topic: self.title, agenda: self.body,
                                start_time: self.scheduled_date.strftime('%Y-%m-%dT%H:%M:%SZ'))
  end

  def delete_zoom_meeting
    zoom_client.meeting_delete(meeting_id: self.zoom_id)
  end

  private
    def zoom_client
      Zoom.new
    end
end
