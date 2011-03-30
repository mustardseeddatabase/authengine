class Role < ActiveRecord::Base
  has_many :roles_users, :dependent=>:delete_all
  has_many :users, :through=>:roles_users

  has_many :action_roles, :dependent=>:delete_all
  has_many :actions, :through => :action_roles

  def to_s
    name
  end
end
