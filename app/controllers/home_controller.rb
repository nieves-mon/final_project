class HomeController < ApplicationController
  skip_before_action :authenticate_user!, :only => [ :index ]
  # skip_before_action :set_organization
  set_current_tenant_through_filter #from acts_as_tenant
  before_action :set_organization, only: :dashboard
  
  def index
  end

  def dashboard
  end

  private

  def set_organization
    if current_user
      current_organization = current_user.organization
      set_current_tenant(current_organization)
    else
      set_current_tenant(nil)
    end
  end


end
