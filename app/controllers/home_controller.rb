class HomeController < ApplicationController
  # skip_before_action :set_organization
  include SetOrganization
  include RequireOrganization
  
  def dashboard
    @organization = current_user.organization
    @projects = current_user.projects
    @meetings = current_user.meetings
    @tasks = current_user.tasks
  end
end
