class CreateUseractionsTable < ActiveRecord::Migration

  def self.up
    create_table "useractions", :force => true do |t|
      t.integer  "user_id"
      t.integer  "action_id"
      t.string   "type"
      t.text     "params"
      t.timestamps
    end
  end

  def self.down
    drop_table "useractions"
  end

end
