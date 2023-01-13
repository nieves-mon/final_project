class Project < ApplicationRecord
  belongs_to :organization
  has_many :project_participants, dependent: :destroy
  has_many :users, through: :project_participants
  has_many :tasks, dependent: :destroy

  validates :title, presence: true, uniqueness: true
  validates :title, length: { in: 2..20 }
  validates :start_date, presence: true
  validates :end_date, presence: true
end
