class Membership < ApplicationRecord

  enum membership_type: [:basic, :pro]

  belongs_to :user

  validates :user_id, presence: true
  #validates :membership_type, presence: true

end
