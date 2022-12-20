class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  set_current_tenant_through_filter #acts_as_tenant
  before_action :set_organization

  def set_organization
    current_organization = current_user.organization
    set_current_tenant(current_organization)
  end
end
