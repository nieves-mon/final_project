class AddZoomIdToMeetings < ActiveRecord::Migration[6.1]
  def change
    add_column :meetings, :zoom_id, :integer, :limit => 8
  end
end
