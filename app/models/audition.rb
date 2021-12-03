class Audition < ApplicationRecord
  require 'csv'
  include PgSearch::Model
  pg_search_scope :search_by,
                  against: [:firstname, :lastname, :email, :status, :genre, :created_at, :id, :artist_name],
                  using: {
                    tsearch: {prefix: true}
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
  CSV_ATTRIBUTES = %w[id name artist_name email genres formatted_created_at assigned_to status].freeze
  NAME_REGEX = /(?=.*[[:^alnum:]])/.freeze
  AUDITION_ACCEPT_EMAIL="Hi [name]!Thanks for submitting music to Audiosocket, we have listened to your link and would love to work with you! Please sign in to our artist portal here. There, you can update your artist profile, submit music, artworks, etc. The more assets you can give us the better. Once submitted, our team will review and will start the ingestion into our catalog.Thanks! Music Licensing Coordinator".freeze
  AUDITION_REJECT_EMAIL="Hello [name],Thank you for submitting an audition. After careful review, we have decided the music you submitted is not a match for our current needs. Please understand, that while your music may not be a match this time, it certainly might be in the future as our clients’ needs are constantly changing.With that in mind, we encourage you to submit new music again in the future.Have a great day!".freeze

  enum status: STATUSES

  validates :firstname, length: { maximum: 30 }, format: { without: NAME_REGEX }
  validates :lastname, length: { maximum: 30 }, format: { without: NAME_REGEX }

  has_many :links, dependent: :destroy

  accepts_nested_attributes_for :links

  after_initialize :default_email_status, if: :new_record?

  scope :by_status, ->(status) { where(status: status) }
  scope :count_by_status, ->(status) { by_status(status).count }

  def self.to_csv
    CSV.generate(headers: true) do |csv|
      csv << CSV_ATTRIBUTES
      all.each do |audition|
        csv <<  audition.csv_row
      end
    end
  end

  def csv_row
    CSV_ATTRIBUTES.map{ |attribute| send(attribute) }
  end

  def self.search(query, sort, direction, status)
    scope = self.all
    scope = scope.search_by(query) if query.present?
    scope = scope.order("#{sort} #{direction}") if sort.present?
    scope = scope.by_status(status) if status.present?

    scope
  end

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

  def manager_assigned(audition)
    audition.assigned_to
  end
end
