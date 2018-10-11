class Video < ApplicationRecord
  extend FriendlyId
  friendly_id :slug, use: :slugged

  is_impressionable :counter_cache => true, :column_name => :view_count, :unique => :session_hash

  include VideoUploader[:video]
  include ImageUploader[:image]

  enum policy_type: [:free, :premium]

  default_scope -> { order('id DESC') }

  belongs_to :user
  belongs_to :category
  belongs_to :subcategory, optional: true

  has_many :comments, dependent: :destroy

  validates :category_id, presence: true
  validates :title, presence: true, length: { maximum: 255 }
  validates :image_data, presence: true, unless: :image_data?
  validates :video_data, presence: true, unless: :video_data?
  validates :description, presence: true, length: { maximum: 5000 }

  before_save :generated_slug

  def self.search(search)
    where("title LIKE ?", "%#{search}%")
  end
    
  private

    def generated_slug
      require 'securerandom' 
      self.slug = SecureRandom.hex(16) if slug.blank?
    end

end
