class Comment < ApplicationRecord

  default_scope -> { order('id DESC') }

  belongs_to :user
  belongs_to :video

  validates :video_id, presence: true
  validates :content, presence: true, length: { maximum: 1000 }

end
