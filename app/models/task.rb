class Task < ApplicationRecord
  belongs_to :project
  belongs_to :user

  validates :title, presence: true, length: { minimum: 2, maximum: 25}
  validates :duedate, :user_id, presence: true

  scope :pending, -> { where("completed = ?", false).order(:duedate) }
  scope :overdue, -> { pending.where("duedate < ?", Date.current) }
  scope :today, -> { pending.where("duedate = ?", Date.current) }
  scope :future, -> { pending.where("duedate > ?", Date.current) }
  scope :completed, -> { where("completed = ?", true).order(:duedate) }
end
