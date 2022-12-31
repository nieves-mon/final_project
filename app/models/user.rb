class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :invitable, :confirmable

  acts_as_tenant :organization
  accepts_nested_attributes_for :organization

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

end
