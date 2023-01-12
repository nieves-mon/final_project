class ChangeDefaultRolesOfUsers < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :roles, {"admin": false, "manager": false}
  end
end
