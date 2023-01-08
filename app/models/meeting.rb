class Meeting < ApplicationRecord
  belongs_to :organization
  has_many :user_meetings, dependent: :destroy
  has_many :users, through: :user_meetings, dependent: :destroy

  def create_zoom_meeting(topic, start_time)
    zoom_client = Zoom.new
    response = zoom_client.meeting_create(topic: topic, user_id: Rails.application.credentials.zoom[:user_id], settings: {start_time: start_time, join_before_host: true})
    response['join_url']
  end

  def save_zoom_link(meeting_topic, start_time)
    return if zoom_link.present?
    _zoom_link = create_zoom_meeting(meeting_topic, start_time)
    update(zoom_link: _zoom_link)
  end
end
