class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :invitable, :confirmable

  acts_as_tenant :organization
  accepts_nested_attributes_for :organization

  has_many :meetings, dependent: :destroy
  validates_uniqueness_to_tenant :email
end
