class User < ApplicationRecord
  attr_accessor :email_content, :update_status
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  ARTIST = 'Artist'.freeze
  MANAGER = 'Manager'.freeze
  ROLES = [ARTIST, MANAGER].freeze

  enum role: ROLES

  has_one :artist_detail

  validates :password, format: { with: /(?=.{8,})(?=.*[A-Z])(?=.*[[:^alnum:]])/}

  scope :manager_role, -> { where(role: MANAGER) }
end
