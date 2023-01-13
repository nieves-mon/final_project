class AddIdToProjectParticipants < ActiveRecord::Migration[6.1]
  def change
    add_column :project_participants, :id, :primary_key
  end
end
