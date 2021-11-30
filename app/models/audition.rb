class Audition < ApplicationRecord
  extend IndexConcern
  require 'csv'
  include PgSearch::Model
  pg_search_scope :search_by,
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

  def self.to_csv
    attributes = %w{id name artist_name email genres formatted_created_at assigned_to status}
    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.each do |audition|
        csv << record_csv(attributes, audition)
      end
    end
  end

  def self.record_csv(attributes, audition)
    attributes.map{ |attribute| audition.send(attribute) }
  end

  def self.search(query, sort, direction, status)
    scope = self.all
    scope = scope.search_by(query) if query.present?
    scope = scope.order("#{sort} #{direction}") if sort.present?
    scope = scope.find_status(status) if status.present?

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

  scope :find_status, ->(status) { where(status: status) }
end
