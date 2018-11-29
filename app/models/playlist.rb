class Playlist < ApplicationRecord
  extend FriendlyId
  friendly_id :slug, use: :slugged

  include ImageUploader[:image]

  scope :newest, -> { order("created_at DESC") }

  enum policy_type: [:open, :closed]

  belongs_to :user

  has_many :adds, dependent: :destroy
  has_many :videos, through: :adds

  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 255 }
  validates :image_data, presence: true, unless: :image_data?
  validates :description, presence: true, length: { maximum: 5000 }

  before_save :generated_slug

  def added?(video)
    Add.exists? playlist_id: id, video_id: video.id
  end

  def unadd(video)
    Add.find_by(playlist_id: id, video_id: video.id).destroy
  end

  def add_id(video)
    Add.find_by(playlist_id: id, video_id: video.id).id
  end
    
  private

    def generated_slug
      require 'securerandom' 
      self.slug = SecureRandom.hex(16) if slug.blank?
    end

end
