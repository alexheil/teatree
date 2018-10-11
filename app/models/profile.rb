class Profile < ApplicationRecord

  include ImageUploader[:image]

  validates :first_name, format: { with: /\A[-a-z]+\z/i }, allow_blank: true
  validates :last_name, format: { with: /\A[-a-z]+\z/i }, allow_blank: true
  validates :biography, length: { maximum: 4000 }, allow_blank: true
  validates :website, format: { with: /\A((http|https)?:\/\/)?(www.)?[a-zA-Z0-9]+.[a-z]+\/?/i }, allow_blank: true
  validates :twitter_handle, length: { maximum: 15 }, allow_blank: true
  validates :instagram_handle, length: { maximum: 75 }, allow_blank: true
  validates :snapchat_handle, length: { maximum: 75 }, allow_blank: true

  belongs_to :user

  before_save :create_twitter_url
  before_save :create_instagram_url
  before_save :create_snapchat_url
  before_save :smart_add_url_protocol
  before_save :downcase

  private

    def create_twitter_url
      self.twitter_url = nil if self.twitter_handle.blank?
      self.twitter_url = "https://twitter.com/#{self.twitter_handle}" if self.twitter_handle.present?
    end

    def create_instagram_url
      self.instagram_url = nil if self.instagram_handle.blank?
      self.instagram_url = "https://instagram.com/#{self.instagram_handle}" if self.instagram_handle.present?
    end

    def create_snapchat_url
      self.snapchat_url = nil if self.snapchat_handle.blank?
      self.snapchat_url = "https://snapchat.com/#{self.snapchat_handle}" if self.snapchat_handle.present?
    end

    def smart_add_url_protocol
      unless self.website[/\Ahttp:\/\//] || self.website[/\Ahttps:\/\//]
        self.website = "https://#{self.website}" unless website.blank?
      end
    end

    def downcase
      self.twitter_url = twitter_url.downcase if self.twitter_url.present?
      self.website = website.downcase if self.website.present?
    end
  
end
