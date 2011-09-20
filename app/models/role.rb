class Role < ActiveRecord::Base
  has_many :user_roles
  has_many :users, :through=>:user_roles

  has_many :action_roles
  has_many :actions, :through => :action_roles

  validates_presence_of :name
  validates_uniqueness_of :name

  before_destroy do
    if users.empty?
      action_roles.clear
    else
      false # don't delete a role if there are users assigned
    end
  end

  def self.developer
    where('name = "developer"').first
  end

  def to_s
    name
  end
end
