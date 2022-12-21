class Organization < ApplicationRecord
    has_many :users, dependent: :destroy
    validates :name, presence: true, uniqueness: true
    validates :name, length: { in: 2..20 }
end
