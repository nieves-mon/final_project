class Organization < ApplicationRecord
    has_many :users, dependent: :destroy
    has_many :meetings, dependent: :destroy
    has_many :projects, dependent: :destroy
    validates :name, presence: true, uniqueness: true
    validates :name, length: { in: 2..20 }
    has_one_attached :logo
    validates :logo, content_type: [:png, :jpg, :jpeg], 
                    size: { less_than: 100.kilobytes , message: 'has to be less than 100 kilobytes' }
end
