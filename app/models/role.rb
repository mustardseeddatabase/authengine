class Role < ActiveRecord::Base
  has_many :user_roles, :dependent=>:delete_all
  has_many :users, :through=>:user_roles

  has_many :action_roles, :dependent=>:delete_all
  has_many :actions, :through => :action_roles

  validates_presence_of :name
  validates_uniqueness_of :name

  def self.developer
    where('name = "developer"').first
  end

  def to_s
    name
  end
end
