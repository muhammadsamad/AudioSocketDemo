class Audition < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search,
                  against: [:firstname, :lastname, :email, :status, :genre, :created_at, :id, :artist_name],
                  using: {
                    tsearch: { prefix: true, any_word: true}
                  }

  GENRES = ['Acapella', 'Acid', 'Jazz', 'Acoustic', 'Acid Punk', 'Alternative', 'Hip Hop', 'Ambient',
            'Avantgarde', 'Bass', 'Blues', 'Cabaret', 'Celtic Chamber', 'Chanson', 'Chorus', 'Christian Rap',
            'Cinematic', 'Classical', 'Classic Rock', 'Club', 'Comedy', 'Country', 'Cult'].freeze
  SOURCES = ['Facebook', 'Instagram', 'Twitter', 'Other'].freeze

  PENDING = "Pending".freeze
  ACCEPTED = "Accepted".freeze
  REJECTED = "Rejected".freeze
  DELETED = "Deleted".freeze
  STATUSES = [PENDING, ACCEPTED, REJECTED, DELETED].freeze

  enum status: STATUSES

  validates :firstname, length: { maximum: 30 }, format: { without: /(?=.*[[:^alnum:]])/ }
  validates :lastname, length: { maximum: 30 }, format: { without: /(?=.*[[:^alnum:]])/ }

  has_many :links, dependent: :destroy

  accepts_nested_attributes_for :links

  after_initialize :default_email_status, if: :new_record?

  def default_email_status
    self.status ||= PENDING
  end

  def name
    "#{firstname} #{lastname}"
  end

  def genres
    genre.join(', ')
  end

  def formatted_created_at
    created_at.strftime("%d %B %y %I:%M %p")
  end

  def self.search_with(query, sort, direction, status)
    scope = self.all
    scope = scope.search(query) if query.present?
    scope = scope.order("#{sort} #{direction}") if sort.present?
    scope = scope.find_status(status) if status.present?
    scope
  end

  def manager_assigned(audition)
    audition.assigned_to
  end

  scope :find_status, ->(status) { where(status: status) }
end
