class AddDateToMeetings < ActiveRecord::Migration[6.1]
  def change
    add_column :meetings, :scheduled_date, :date
  end
end
