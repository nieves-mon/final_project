class AddUserFromUserMeetings < ActiveRecord::Migration[6.1]
  def change
    add_column :user_meetings, :user_id, :integer, null: false, foreign_key: true
  end
end
