class CreateActionRolesTable < ActiveRecord::Migration
  def self.up
    create_table "action_roles", :force => true do |t|
      t.integer  "role_id",    :limit => 8
      t.integer  "action_id",  :limit => 8
      t.timestamps
    end
  end

  def self.down
    drop_table "action_roles"
  end

end
