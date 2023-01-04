class CreateUserMeetings < ActiveRecord::Migration[6.1]
  def change
    create_table :user_meetings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :meeting, null: false, foreign_key: true

      t.timestamps
    end
  end
end
