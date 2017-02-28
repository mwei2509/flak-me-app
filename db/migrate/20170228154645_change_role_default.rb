class ChangeRoleDefault < ActiveRecord::Migration[5.0]
  def change
    change_column_default :roles, :role_type, "member"
  end
end
