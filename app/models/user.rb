class User < ApplicationRecord
  has_many :sessions
  has_many :tweets
  has_secure_password

  validates :username, presence: true, length: { minimum: 3, maximum: 64 }, uniqueness: true
  validates :password, presence: true, length: { minimum: 8, maximum: 64 }
  validates :email, presence: true, length: { minimum: 5, maximum: 500 }

end
