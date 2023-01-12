class AddStartdateToProjects < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :start_date, :date
  end
end