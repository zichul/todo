class List < ActiveRecord::Base

  has_secure_token
  belongs_to :user
  has_many :todos
  validates :user, presence: true
  validates :share_code, presence: true

end
