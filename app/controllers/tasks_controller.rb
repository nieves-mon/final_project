class TasksController < ApplicationController
    before_action :set_project
    before_action :set_task, except: [ :new, :create ]

    def show
    end

    def new
        @task = Task.new
    end

    def create
        @task = @project.tasks.build(task_params)

        if @task.save
            redirect_to project_path(@project.organization, @project), notice: "Task was successfully created"
        else
            render :new
        end
    end

    private
        def task_params
            params.require(:task).permit(:title, :notes, :duedate, :completed, :project_id)
        end

        def set_project
            @project = Project.find(params[:project_id])
        end

        def set_task
            @task = Task.find(params[:id])
        end
end
