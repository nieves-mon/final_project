class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :invitable, :confirmable

  acts_as_tenant :organization
  accepts_nested_attributes_for :organization

  has_many :meetings, dependent: :destroy
  has_and_belongs_to_many(:projects)
  validates_uniqueness_to_tenant :email

  # List of user roles
  ROLES = [:admin, :employee]

  # JSON column to store roles
  store_accessor :roles, *ROLES

  # Cast roles to/from booleans

  ROLES.each do |role|
    scope role, -> { where("roles @> ?", {role => true}.to_json) }
    define_method(:"#{role}=") { |value| super ActiveRecord::Type::Boolean.new.cast(value) }
    define_method(:"#{role}?") { send(role) }
  end

  def active_roles # where value is true
    ROLES.select { |role| send(:"#{role}?") }.compact
  end

  validate :must_have_a_role, on: :update
  validate :must_have_an_admin

  private

  def must_have_a_role
    if self.roles.values.none?
      errors.add(:base, "A member must have at least one role")
    end
  end

  def must_have_an_admin
    if (self.organization.users.pluck(:roles).count { |h| h["admin"] == true } == 1) && (roles_changed? && admin == false)
      errors.add(:base, "An organization must have at least one admin.")
    end
  end

end
