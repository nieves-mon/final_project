class Meeting < ApplicationRecord
  # belongs_to :organization
  acts_as_tenant(:organization)
  has_many :user_meetings, dependent: :destroy
  has_many :users, through: :user_meetings
end
