class ProjectsController < ApplicationController
  include SetOrganization
  include RequireOrganization #if no organization is set, access will not be allowed to whole UsersController

  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :require_manager, only: [:edit, :update, :destroy]
  before_action :require_member, only: [:show]

  def index
    @overdue = current_user.projects.overdue
    @pending = current_user.projects.pending
    @completed = current_user.projects.completed
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      current_user.update!(project_manager: true) if !current_user.project_manager? #anyone who creates a project will become its manager
      @project.users << current_user
      redirect_to project_path(@project.organization, @project.id), notice: "Project was successfully created."
    else
      render :new
    end
  end

  def show
    @overdue_tasks = @project.tasks.overdue
    @today_tasks = @project.tasks.today
    @future_tasks = @project.tasks.future
    @completed_tasks = @project.tasks.completed
  end

  def edit
  end

  def update
    if @project.update(project_params)
      redirect_to project_path(@project.organization, @project.id), notice: "Project was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    current_user.update!(project_manager: false) if current_user.projects.count == 0
    redirect_to projects_path, notice: "Project was successfully deleted."
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :body, :start_date, :end_date, :complete, user_ids: [])
  end

  def require_manager
    if current_user.project_manager? && @project.users.include?(current_user)
        # allow to proceed
    else
        redirect_to projects_path, alert: "You are not authorized to perform this action."
    end
  end

  def require_member
    if @project.users.include?(current_user)
        #allow to proceed
    else
        redirect_to projects_path, alert: "You are not authorized to perform this action."
    end
  end

end
