class Meeting < ApplicationRecord
  belongs_to :organization
  has_many :user_meetings, dependent: :destroy
  has_many :users, through: :user_meetings, dependent: :destroy
end
