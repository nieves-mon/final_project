class ChangeDefaultRolesOfUsers2 < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :roles, {"admin": false, "meeting_manager": false, "project_manager": false}
  end
end
