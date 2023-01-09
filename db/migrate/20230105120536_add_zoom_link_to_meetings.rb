class AddZoomLinkToMeetings < ActiveRecord::Migration[6.1]
  def change
    add_column :meetings, :zoom_link, :string
  end
end
