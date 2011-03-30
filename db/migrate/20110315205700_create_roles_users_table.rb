class CreateRolesUsersTable < ActiveRecord::Migration

  def self.up
    create_table "roles_users", :force => true do |t|
      t.integer  "role_id",    :limit => 8, :null => false
      t.integer  "user_id",    :limit => 8, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table "roles_users"
  end
end  
