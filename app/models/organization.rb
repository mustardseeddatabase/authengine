class Organization < ActiveRecord::Base
  has_many :users
  has_many :households
  validates :name, :presence => true
  scope :active, where('active = ?', true)
  scope :inactive, where('active = ?', false)
  scope :pantries, where('pantry = ?', true)

  validate :either_pantry_or_referrer_must_be_true

  def either_pantry_or_referrer_must_be_true
    errors[:base] << "Either pantry or referral agency, or both, must be checked" unless pantry || referrer
  end

  def <=>(other)
    name <=> other.name
  end
end
