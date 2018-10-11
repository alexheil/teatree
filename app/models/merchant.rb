class Merchant < ApplicationRecord

  belongs_to :user

  attr_accessor :line1, :city, :postal_code, :state, :personal_id_number, :ssn_last_4, :bank_account_number, :bank_routing_number

  validates :user_id, presence: true
  validates :month, presence: true, length: { maximum: 2 }, numericality: { less_than_or_equal_to: 12, greater_than: 0 }
  validates :day, presence: true, length: { maximum: 2 }, numericality: { less_than_or_equal_to: 31, greater_than: 0 }
  validates :year, presence: true, length: { is: 4 }, numericality: { less_than_or_equal_to: 2015, greater_than: 1940 }
  validates :country, presence: true

end
