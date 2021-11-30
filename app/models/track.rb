class Track < ApplicationRecord
  has_one_attached :audio
  belongs_to :album

  validates :audio, content_type: [:wav, :mp3]

  SUBMIT = 'Submit'.freeze
  SUBMITTED = 'Submitted'.freeze
  STATUSES = [SUBMIT, SUBMITTED].freeze
  enum status: STATUSES

  after_save :save_album_status_track

  def save_album_status_track
    if self.status == "Submitted"
      if self.album.album_status == false
        self.album.album_status = true
        self.album.save
      end
    end
  end

end
