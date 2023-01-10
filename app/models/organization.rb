class Organization < ApplicationRecord
    has_many :users, dependent: :destroy
    has_many :meetings, dependent: :destroy
    has_many :projects, dependent: :destroy
    validates :name, presence: true, uniqueness: true
    validates :name, length: { in: 2..20 }
    has_one_attached :logo
end
