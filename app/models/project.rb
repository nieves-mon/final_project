class Project < ApplicationRecord
  # belongs_to :organization
  acts_as_tenant :organization
  has_many :project_participants, dependent: :destroy
  has_many :users, through: :project_participants
  has_many :tasks, dependent: :destroy

  validates :title, presence: true, uniqueness: true
  validates :title, length: { in: 2..20 }
  validates :start_date, presence: true
  validates :end_date, presence: true

  scope :not_complete, -> { where("complete = ?", false).order(:end_date) }
  scope :overdue, -> { not_complete.where("end_date < ?", Date.current) }
  scope :pending, -> { not_complete.where("end_date >= ?", Date.current) }
  scope :completed, -> { where("complete = ?", true).order(:end_date) }
end
