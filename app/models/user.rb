class User < ApplicationRecord
  attr_accessor :email_content, :update_status
  ARTIST = 'Artist'.freeze
  MANAGER = 'Manager'.freeze
  ROLES = [ARTIST, MANAGER].freeze

  enum role: ROLES
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :password, format: { with: /(?=.{8,})(?=.*[A-Z])(?=.*[[:^alnum:]])/}
end
