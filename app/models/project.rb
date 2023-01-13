class Project < ApplicationRecord
  acts_as_tenant :organization
  has_many :project_participants
  has_many :users, through: :project_participants
end
