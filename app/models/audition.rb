class Audition < ApplicationRecord
  extend IndexConcern
  require 'csv'

  include PgSearch::Model
  pg_search_scope :search,
                  against: [:firstname, :lastname, :email, :status, :genre, :created_at, :assigned_to, :id, :artist_name],
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

  def self.to_csv
    attributes = %w{id name artist_name email genres submitted assigned_to status}
    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.find_each do |audition|
        csv << attributes.map{ |attr| audition.send(attr) }
      end
    end
  end

  def name
    "#{firstname} #{lastname}"
  end

  def genres
    "#{genre.join(', ')}"
  end

  def submitted
    "#{created_at.strftime('%d %B %y %I:%M %p')}"
  end
end
