class Membership < ApplicationRecord

  enum membership_type: [:basic, :pro]

  attr_accessor :promo_code

  belongs_to :user

  validates :user_id, presence: true
  #validates :membership_type, presence: true

end
