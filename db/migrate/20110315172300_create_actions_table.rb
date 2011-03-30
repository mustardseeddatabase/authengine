class CreateActionsTable < ActiveRecord::Migration
  def self.up
    create_table "actions", :force => true do |t|
      t.string   "action_name"
      t.integer  "controller_id"
      t.timestamps
    end
  end

  def self.down
    drop_table "actions"
  end
end
