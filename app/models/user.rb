class User < ApplicationRecord
  ARTIST = 'Artist'.freeze
  MANAGER = 'Manager'.freeze
  enum role: [ARTIST, MANAGER]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :password, format: { with: /(?=.{8,})(?=.*[A-Z])(?=.*[[:^alnum:]])/}
end
