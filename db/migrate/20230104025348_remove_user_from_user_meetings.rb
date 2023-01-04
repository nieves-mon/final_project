class RemoveUserFromUserMeetings < ActiveRecord::Migration[6.1]
  def change
    remove_reference :user_meetings, :user, null: false, foreign_key: true
  end
end
