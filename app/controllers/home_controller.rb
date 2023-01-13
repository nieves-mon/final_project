class HomeController < ApplicationController
  # skip_before_action :set_organization
  include SetOrganization
  include RequireOrganization
  
  def dashboard
    @organization = current_user.organization
  end
end
