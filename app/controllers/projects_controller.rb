class ProjectsController < ApplicationController
  def index
    @organization = current_user.organization
    @projects = @organization.projects
  end

  def new
    @organization = current_user.organization
    @project = @organization.projects.build
  end

  def create
    @organization = current_user.organization
    @project = @organization.projects.build(project_params)
    @project.user_id = current_user.id
    if @project.save
      redirect_to projects_path, notice: "Project was successfully created."
    else
    end
  end

  def show
    @organization = current_user.organization
    @project = @organization.projects.find(params[:id])
  end

  def edit
    @organization = current_user.organization
    @project = @organization.projects.find(params[:id])
  end

  def update
    @organization = current_user.organization
    @project = @organization.projects.find(params[:id])
    if @project.update(project_params)
      redirect_to projects_path, notice: "Project was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @organization = current_user.organization
    @project = @organization.projects.find(params[:id])
    @project.destroy
    redirect_to projects_path, notice: "Project was successfully deleted."
  end

  def project_params
    params.require(:project).permit(:title, :body, :start_date, :end_date, user_ids: [])
  end

end
