class Task < ApplicationRecord
  belongs_to :project
  belongs_to :user

  scope :pending, -> { where("completed = ?", false).order(:duedate) }
  scope :overdue, -> { pending.where("duedate < ?", Date.current) }
  scope :today, -> { pending.where("duedate = ?", Date.current) }
  scope :future, -> { pending.where("duedate > ?", Date.current) }
  scope :completed, -> { where("completed = ?", true).order(:duedate) }
end
