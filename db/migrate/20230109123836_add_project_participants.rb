class AddProjectParticipants < ActiveRecord::Migration[6.1]
  def change
    create_table :project_participants, id: false do |t|
      t.belongs_to :user, index: true
      t.belongs_to :project, index: true
    end
  end
end
