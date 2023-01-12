class AddEnddateToProjects < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :end_date, :date
  end
end