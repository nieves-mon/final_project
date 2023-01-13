class ProjectParticipantsController < ApplicationController

  before_action :set_organization, only: [:new, :create, :destroy]
  before_action :set_project, only: [:new, :create, :destroy]
  before_action :set_user, only: [:new]
  before_action :require_manager, only: [:new, :create, :destroy]

    def new
    end

    def create
      @user_in_org = @organization.users.find_by(email: params[:user][:email])
      @user_in_project = @project.users.find_by(email: params[:user][:email])

      if @user_in_project.nil? && @user_in_org.present?
        @project_participant = @project.users << @user_in_org
        redirect_to projects_path, notice: "User successfully added as participant"
      elsif @user_in_project.nil? && @user_in_org.nil?
        redirect_to projects_path, notice: "User not a part of the organization"
      else
        redirect_to projects_path, notice: "User already a participant in the meeting"
      end
    end

    def show
    end

    def edit
    end

    def update
      if @project_participant.update(project_params)
        redirect_to projects_path, notice: "Project participant was successfully updated."
      else
        render :edit
      end
    end

    def destroy
      @project_participant = @project.users.find(params[:id])
      @project_participant.tasks.each { |task| task.unassign }
      @project.users.delete(@project_participant)

      redirect_to project_path(@project.organization, @project)
    end


  private

    def set_organization
      @organization = current_user.organization
    end

    def set_project
      @project = @organization.projects.find(params[:project_id])
    end

    def set_user
      @user = @project.users.build(email: params[:email])
    end

    def require_manager
      if current_user.project_manager? && @project.users.include?(current_user)
          # allow to proceed
      else
          redirect_to projects_path, alert: "You are not authorized to perform this action."
      end
    end

  end
