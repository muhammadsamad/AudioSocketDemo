class ArtistDetail < ApplicationRecord
  has_one_attached :profile
  has_many :albums
  belongs_to :user

  validates :profile, dimension: { min: 353..353 }
end
