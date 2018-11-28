class Add < ApplicationRecord

  belongs_to :playlist
  belongs_to :video

  validates :playlist_id, presence: true
  validates :video_id, presence: true

end
