class Playlist < ApplicationRecord
  extend FriendlyId
  friendly_id :slug, use: :slugged

  include ImageUploader[:image]

  scope :newest, -> { order("created_at DESC") }

  enum policy_type: [:public, :private]

  belongs_to :user

  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 255 }
  validates :image_data, presence: true, unless: :image_data?
  validates :description, presence: true, length: { maximum: 5000 }

  before_save :generated_slug
    
  private

    def generated_slug
      require 'securerandom' 
      self.slug = SecureRandom.hex(16) if slug.blank?
    end

end
