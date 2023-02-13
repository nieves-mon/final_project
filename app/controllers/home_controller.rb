class HomeController < ApplicationController
  # skip_before_action :set_organization
  include SetOrganization
  include RequireOrganization

  def dashboard
    @organization = current_user.organization
    @num_projects = current_user.projects.not_complete.count
    @num_meetings = current_user.meetings.today.count
    @tasks = current_user.tasks.pending.order(:duedate)
  end
end
