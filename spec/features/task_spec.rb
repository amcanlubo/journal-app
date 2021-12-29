require 'rails_helper'

RSpec.describe 'Task', type: :feature do
    
    before(:each) do
        User.destroy_all
        Category.destroy_all
        Task.destroy_all
        sign_in create(:user)    
    end
    
    let!(:category) { Category.create(name: 'A valid category') }
    let!(:task) { category.tasks.create(name:'A valid task name', body:'A valid task body', task_date: Date.current) }

    context 'As a User, I want to view a task to show task\'s details' do
       # before { visit categories_path }
        it 'shows all tasks' do
            visit category_path(Category.last.id)
            expect(page).to have_content 'All Tasks'
            expect(page).to have_content 'New Task'
        end
    end

    context 'As a User, I want to create a task for a specific category so that I can organize tasks quicker' do
        it 'creates a new task' do
            expect(Category.count).to eq(1)
            visit category_path(Category.last.id)
            # "/categories/1/tasks/1"
            expect(page).to have_content 'All Tasks'
            expect(page).to have_content 'New Task'
            
            click_on 'New Task'
            expect(page).to have_current_path new_category_task_path(Category.last.id)
            # "/categories/1/tasks/1/new"
           
            within 'form' do
                fill_in 'Name', :with => 'Task name'
                fill_in 'Body', :with => 'This is task body'
                fill_in 'Task date', with: Date.current
                expect { click_on 'Create Task' }.to change(Task, :count).by(1) 
                # click_on 'Create task'
            end 
            expect(page).to have_content('Task was successfully created')
            # expect(Task.count).to eq(1)
        end
    end

    context 'Edit a task to update task details' do
        it 'Successfully updates the task' do
            visit category_path(Category.last.id)
            click_on 'Edit'
            expect(page).to have_current_path edit_category_task_path(Category.last.id, task.id)
            # "/categories/1/tasks/1/edit"
            
            within 'form' do
                fill_in 'Name', :with => 'Updated task name'
                fill_in 'Body', :with => 'Updated task body'
                 # fill_in "Task date", :with => Date.current
                click_button 'Update Task'
            end
            expect(page).to have_content('Updated task name')
            expect(page).to have_content('Updated task body')
            expect(page).to have_content('Task was successfully updated')
        end
    end    

    context 'As a User, I want to delete a task to lessen my unnecessary daily tasks' do
        it 'Destroys the task' do
            visit category_path(Category.last.id)
            # visit "/categories/1/tasks/1"
            expect(page).to have_content 'Delete'
            expect { click_on 'Delete' }.to change(Task, :count).by(-1)
            expect(page).to have_content('Task was successfully deleted')
        end
    end

    context 'As a User, I want to view my tasks for today per category for me to remind what are my priorities for today' do
        it 'Successfully display tasks today per category' do
            visit category_path(Category.last.id)
            # visit "/categories/1/tasks/1"
            expect(page).to have_content('CATEGORY')
            expect(page).to have_content('TASKS FOR TODAY')
        end
    end

    context 'As a User, I want to view all of my priority tasks of all categories for today' do
        it 'Successfully display tasks today for all categories' do
            visit categories_path
            # visit "/categories/1/tasks/1"
            expect(page).to have_content('CATEGORIES')
            expect(page).to have_content('TASKS FOR TODAY')
        end
    end
end