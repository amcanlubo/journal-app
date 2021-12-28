class TasksController < ApplicationController
    before_action :authenticate_user!
    before_action :get_category, except: [:today]
    before_action :set_task, only: %i[ show edit update destroy ]
    
    def index
      # @tasks = @category.tasks
    end
  
    
    def show
      # @task = Task.find(params[:id])
      @task = @category.tasks.find(params[:id])
    end

    def today
      @tasks_today = Task.where(task_date:Date.today)
      # task.task_date == Date.today
    end
  
    
    def new
    end
  
    
    def create
      respond_to do |format|
        @category = Category.find(params[:category_id])
        @task = @category.tasks.create(task_params)
        format.html{redirect_to category_path(@category), notice: "Task was successfully created."}
      end
    end
  
    def edit
      @task = @category.tasks.find(params[:id])
    end
  
    def update
      
      respond_to do |format|
        if @task.update(task_params)
          format.html { redirect_to @task.category, notice: "Task was successfully updated" }
        else
          format.html { render :edit, status: :unprocessable_entity }
        end
      end
    end
  
  
    def destroy
      # @task = @category.tasks.find(params[:id])
      @task.destroy
  
      respond_to do |format|
        format.html { redirect_to category_path(@category), notice: "Task was successfully deleted" }
        format.json { head :no_content }
      end
    end
  
    
  
    private
      def set_task
        @task = Task.find(params[:id])
      end
  
      def get_category
        @category = Category.find(params[:category_id])
      end
  
      def task_params
        params.require(:task).permit(:category_id, :name, :body, :task_date)
      end
  end
  