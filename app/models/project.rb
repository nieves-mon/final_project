class Project < ApplicationRecord
  belongs_to :organization
  has_many :project_participants, dependent: :destroy
  has_many :users, through: :project_participants
  has_many :tasks, dependent: :destroy
end
