class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  ARTIST = 'Artist'.freeze
  MANAGER = 'Manager'.freeze
  ROLES = [ARTIST, MANAGER].freeze
  PASSWORD_REGEX = /(?=.{8,})(?=.*[A-Z])(?=.*[[:^alnum:]])/.freeze

  enum role: ROLES

  validates :password, format: { with: PASSWORD_REGEX }

  scope :managers, -> { where(role: MANAGER) }
end
