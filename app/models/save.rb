class Save < ApplicationRecord

  scope :newest, -> { order("created_at DESC") }

  belongs_to :user
  belongs_to :video

  validates :user_id, presence: true
  validates :video_id, presence: true

end
