class Meeting < ApplicationRecord
  belongs_to :organization
  has_many :user_meetings, dependent: :destroy
  has_many :users, through: :user_meetings, dependent: :destroy

  def create_zoom_meeting(topic, start_time)
    zoom_client = Zoom.new
    response = zoom_client.meeting_create(topic: topic, user_id: Rails.application.credentials.zoom[:user_id],
                                          settings: {start_time: start_time, join_before_host: true})
    [response['join_url'], response['id']]
  end

  def save_zoom_meeting(meeting_topic, start_time)
    return if zoom_link.present?
    _zoom_link, _zoom_id = create_zoom_meeting(meeting_topic, start_time)
    update(zoom_link: _zoom_link, zoom_id: _zoom_id)
  end

  def delete_zoom_meeting(meeting_id)
    zoom_client = Zoom.new
    zoom_client.meeting_delete(meeting_id: meeting_id)
  end
end
