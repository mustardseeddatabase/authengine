class CreateControllersTable < ActiveRecord::Migration
  def self.up
    create_table "controllers", :force => true do |t|
      t.string   "controller_name"
      t.datetime "last_modified"
      t.timestamps
    end
  end

  def self.down
    drop_table "controllers"
  end
end
