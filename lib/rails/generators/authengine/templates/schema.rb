ActiveRecord::Schema.define(:version => 0) do

  create_table "useractions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "action_id"
    t.string   "type"
    t.text     "params"
    t.timestamps
  end

  create_table "roles_users", :force => true do |t|
    t.integer  "role_id",    :limit => 8, :null => false
    t.integer  "user_id",    :limit => 8, :null => false
    t.timestamps
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.string   "short_name"
    t.timestamps
  end

  create_table "controllers", :force => true do |t|
    t.string   "controller_name"
    t.datetime "last_modified"
    t.timestamps
  end

  create_table "action_roles", :force => true do |t|
    t.integer  "role_id",    :limit => 8
    t.integer  "action_id",  :limit => 8
    t.timestamps
  end

  create_table "actions", :force => true do |t|
    t.string   "action_name"
    t.integer  "controller_id"
    t.timestamps
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.string   "password_reset_code",       :limit => 40
    t.boolean  "enabled",                                 :default => true
    t.string   "firstName"
    t.string   "lastName"
    t.string   "type"
    t.string   "status"
    t.timestamps
  end

  # add_index ?

end
