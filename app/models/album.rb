class Album < ApplicationRecord
  has_one_attached :artwork
  has_many :tracks, dependent: :destroy
  belongs_to :artist_detail

  after_initialize :default_status, if: :new_record?

  def default_status
    self.album_status = false
  end
end
