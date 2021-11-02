class Audition < ApplicationRecord

  has_many :links, dependent: :destroy
  accepts_nested_attributes_for :links

  validates :firstname, length: { maximum: 30 }, format: { without: /(?=.*[[:^alnum:]])/ }
  validates :lastname, length: { maximum: 30 }, format: { without: /(?=.*[[:^alnum:]])/ }

  before_validation :remove_empty_string_from_genre

  def remove_empty_string_from_genre
    genre.reject!(&:blank?)
  end

  GENRES = ['Acapella', 'Acid', 'Jazz', 'Acoustic', 'Acid', 'Acid Punk', 'Alternative', 'Hip Hop', 'Ambient',
            'Avantgarde', 'Bass', 'Blues', 'Cabaret', 'Celtic Chamber', 'Chanson', 'Chorus', 'Christian Rap',
            'Cinematic', 'Classical', 'Classic Rock', 'Club', 'Comedy', 'Country', 'Cult' ].freeze
  SOURCES = ['Facebook', 'Instagram', 'Twitter', 'Other'].freeze

end
