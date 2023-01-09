class ProjectParticipantsController < ApplicationController
  
  skip_before_action :verify_authenticity_token
  before_action :set_organization, only: [:new, :create, :delete, :destroy]
  before_action :set_project, only: [:new, :create, :delete, :destroy]
  
    def index
    end

    def new
    end

    def create
      @project_participant = @project.users.find_by(email: params[:email])
      redirect_to project_project_participant_path
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
      @project_participant.destroy
      redirect_to projects_path, notice: "Project participant was successfully deleted."
    end
  
  private

  def project_participant_params
    params.require(:task).permit(:name, :notes, :due_date, :complete)
  end

    def set_organization
      @organization = current_user.organization
    end

    def set_project
      @project = @organization.projects.find(params[:project_id])
    end
  
  end