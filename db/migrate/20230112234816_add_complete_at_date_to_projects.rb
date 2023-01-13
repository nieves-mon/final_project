class AddCompleteAtDateToProjects < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :complete_at, :date
  end
end
