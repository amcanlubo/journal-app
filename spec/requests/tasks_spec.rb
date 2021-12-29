 require 'rails_helper'

RSpec.describe "/tasks", type: :request do
    
    before(:each) do 
      # User.destroy_all
      sign_in create(:user)
      Category.destroy_all
    end

    after(:all) do
      User.destroy_all
    end
  

    let(:category) { Category.create!(name: 'Category Title') }
    let(:task) { category.tasks.create!(category_id: category.id,name: 'Task Details',body: 'Task Body Details',task_date: Date.current) }

      describe "GET /index" do
        it "renders a successful response" do
          get category_tasks_path(category.id)
          expect(response).to be_successful
        end
      end

      describe "GET /show" do
        it "renders a successful response" do
          get category_task_path(category.id, task.id)
          expect(response).to be_successful
        end
      end

      describe "GET /new" do
        it "renders a successful response" do
          get new_category_task_path(category.id)
          expect(response).to be_successful
        end
      end

      describe "POST /create" do
        it "creates a new task with valid parameters" do
          expect {
            post category_tasks_path(category.id), params: { task: { category_id:category.id, name:'A valid name', body:'A valid body', task_date:Date.current }}
          }.to change(Task, :count).by(1)
        end
    end

      describe "GET /edit" do
        it "render a successful response" do
          get edit_category_task_path(category.id, task.id)
          expect(response).to be_successful
        end
      end

      describe "PATCH /update" do 
        it "with valid parameters, updates the task do" do
          patch category_task_path(category.id, task.id), params: { task: { category_id:category.id, name:'Updated name', body:'A valid body', task_date:Date.current }}
          task.reload
          # expect(response).to be_successful
          expect(task.name).to eq('Updated name')
          expect(response).to have_http_status(302)
        end
        
      end

    describe "DELETE /destroy" do
      it "destroys the requested task" do
        expect do
          delete category_task_path(category.id, task.id)
        end.to change(Task, :count).by(0)
      end
    end
end
