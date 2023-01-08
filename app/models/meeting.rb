class Meeting < ApplicationRecord
  belongs_to :organization
  has_many :user_meetings, dependent: :destroy
  has_many :users, through: :user_meetings, dependent: :destroy

  def create_zoom_meeting(topic, agenda, start_time)
    response = zoom_client.meeting_create(topic: topic, agenda: agenda,
                                          user_id: Rails.application.credentials.zoom[:user_id],
                                          settings: {join_before_host: true},
                                          start_time: start_time.strftime('%Y-%m-%dT%H:%M:%SZ'))
    [response['join_url'], response['id']]
  end

  def save_zoom_meeting(meeting_topic, meeting_agenda, start_time)
    return if zoom_link.present?
    _zoom_link, _zoom_id = create_zoom_meeting(meeting_topic, meeting_agenda, start_time)
    update(zoom_link: _zoom_link, zoom_id: _zoom_id)
  end

  def delete_zoom_meeting(meeting_id)
    zoom_client.meeting_delete(meeting_id: meeting_id)
  end

  private
    def zoom_client
      Zoom.new
    end
end
