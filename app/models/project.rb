class Project < ApplicationRecord
  belongs_to :organization
  has_many :project_participants
  has_many :users, through: :project_participants
end
