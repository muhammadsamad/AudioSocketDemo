class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  ARTIST = 'Artist'.freeze
  MANAGER = 'Manager'.freeze
  ROLES = [ARTIST, MANAGER].freeze

  validates :password, format: { with: /(?=.{8,})(?=.*[A-Z])(?=.*[[:^alnum:]])/}

  enum role: ROLES

  scope :managers, -> { where(role: MANAGER) }
end
