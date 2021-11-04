class Audition < ApplicationRecord
  include RemoveBlankGenreHelper

  GENRES = ['Acapella', 'Acid', 'Jazz', 'Acoustic', 'Acid Punk', 'Alternative', 'Hip Hop', 'Ambient',
            'Avantgarde', 'Bass', 'Blues', 'Cabaret', 'Celtic Chamber', 'Chanson', 'Chorus', 'Christian Rap',
            'Cinematic', 'Classical', 'Classic Rock', 'Club', 'Comedy', 'Country', 'Cult' ].freeze
  SOURCES = ['Facebook', 'Instagram', 'Twitter', 'Other'].freeze

  validates :firstname, length: { maximum: 30 }, format: { without: /(?=.*[[:^alnum:]])/ }
  validates :lastname, length: { maximum: 30 }, format: { without: /(?=.*[[:^alnum:]])/ }

  has_many :links, dependent: :destroy

  accepts_nested_attributes_for :links

  before_validation :remove_blank_genre
end
