class Organization < ActiveRecord::Base
  has_many :users
  validates :name, :presence => true
  scope :active, where('active = ?', true)
  scope :inactive, where('active = ?', false)
end
