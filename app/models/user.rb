class User < ActiveRecord::Base
  has_many :lists, dependent: :destroy

  authenticates_with_sorcery!
  validates :email, :password, presence: true
  validates_confirmation_of :password, message: "should match confirmation", if: :password
  validates :email, uniqueness: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :password, length: 8..20
end

