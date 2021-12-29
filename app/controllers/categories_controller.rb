class CategoriesController < ApplicationController
    before_action :authenticate_user!
    
    def index
        @categories = Category.all
        @today = Task.where(task_date:Date.today)
    end

    def show
        @category = Category.find(params[:id])
        @tasks = @category.tasks
        @tasks_today = @tasks.where(task_date:Date.today)
    end

    def new
        @category = Category.new
    end

    def create 
        @category = Category.new(category_params)
        respond_to do |format|
            if @category.save
                format.html{ redirect_to @category,notice:"Category was successfully created."}
            else
                format.html{ render :new, status: :unprocessable_entity, alert:"Invalid category!" }
            end
        end
    end

    def edit
        @category = Category.find(params[:id])
    end
    
    def update
        @category = Category.find(params[:id])
        respond_to do |format|
            if @category.update(category_params)
                format.html{redirect_to @category, notice: "Category was successfully updated."}
            else
                format.html{ render :edit, status: :unprocessable_entity }
                # render :edit, status: :unprocessable_entity
            end
        end
    end

    def destroy
        respond_to do |format|
            @category = Category.find(params[:id])
            @category.destroy
            format.html{ redirect_to categories_path, notice: "Category was successfully deleted." }
        end
    end

    private
   
    def category_params
      params.require(:category).permit(:name)
    end

  end
  