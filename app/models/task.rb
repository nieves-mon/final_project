class Task < ApplicationRecord
  belongs_to :project
  belongs_to :user, optional: true

  validates :title, presence: true, length: { minimum: 2, maximum: 25}
  validates :duedate, presence: true

  scope :pending, -> { where("completed = ?", false).order(:duedate) }
  scope :overdue, -> { pending.where("duedate < ?", Date.current) }
  scope :today, -> { pending.where("duedate = ?", Date.current) }
  scope :future, -> { pending.where("duedate > ?", Date.current) }
  scope :completed, -> { where("completed = ?", true).order(:duedate) }

  def unassign
    self.update!(user_id: nil)
  end
end
