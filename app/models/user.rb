class User < ApplicationRecord
  has_many :messages
  has_many :roles, dependent: :destroy
  has_many :groups, through: :roles

  validates :username, presence: true, uniqueness: true
  has_secure_password
end
