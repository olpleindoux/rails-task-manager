class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = policy_scope(Task).order(created_at: :desc)
  end

  def show; end

  def new
    @task = Task.new
    authorize @task
  end

  def create
    @task = Task.new(task_params)
    @user = current_user
    @task.user = @user
    authorize @task
    if @task.save
      redirect_to task_path(@task)
    else
      render :new
    end

    # no need for app/views/tasks/create.html.erb
  end

  def edit; end

  def update
    @task.update(task_params)
    authorize @task

    redirect_to task_path(@task)
  end

  def destroy
    @task.destroy
    authorize @task

    redirect_to tasks_path
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :details, :completed)
  end
end
