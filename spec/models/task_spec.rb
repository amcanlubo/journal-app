require 'rails_helper'

RSpec.describe Task, type: :model do
  
  before(:each) do 
    Category.destroy_all
  end

  let(:category) { Category.create!(name: 'Sample Category') }
  let(:task) { Task.create!(category_id: category.id, name:'A valid task name', body:"A valid task body",task_date: Date.current)}

    context 'Create a task for a specific category so that user can organize tasks quicker' do
      it "creates a new task" do
        # task = category.tasks.create!(category_id: Category.last.id, name:"A new valid task name", body:"A new valid task body",task_date: Date.current)
        expect(task).to be_valid
        expect(task.errors).to_not be_present
        expect(Task.count).to eq(1)
      end
    end

    context 'Edit a task to update task\'s details' do
      it 'edits a task with valid parameters' do
        # task = category.tasks.create!(category_id: Category.last.id, name:"A valid task name", body:"A valid task body",task_date: Date.current)
        task.update!(name:'first task edited')
        
        expect(task.name).to eq('first task edited')
        expect(task).to be_valid
      end
    end

    context 'view a task to show task details' do
      it 'shows a task' do
        expect(task.name).to eq('A valid task name')
        expect(task.body).to eq('A valid task body')
      end
    end

    context 'delete a task to lessen my unnecessary daily tasks' do
      it 'deletes a task' do
        task = category.tasks.create!(category_id: category.id, name:"A valid task name", body:"A valid task body",task_date: Date.current)
        task.destroy

        # expect { task.destroy }.to change { Task.count }.by(-1)
        expect(Task.count).to eq(0)
        expect(task).to be_valid
        # expect(task).to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'Task Validations' do
      it '1. Is not valid without a name' do
        # task = category.tasks.new(category_id: Category.last.id, name:nil, body:"A valid task body",task_date: Date.current)
        # taskk = category.tasks.new :name => nil
        task.name = nil
        expect(task).to_not be_valid
        expect(task.errors).to be_present
        expect(task.errors.to_hash.keys).to include(:name)

        task.name = 'A valid task name'
        expect(task).to be_valid
      end

      it '2. Is not valid when name has a duplicate' do
       
        task1 = category.tasks.create!(category_id: Category.last.id, name:'A valid task name', body:'A valid task body',task_date: Date.current)
        task2 = category.tasks.new(category_id: Category.last.id, name:'A valid task name', body:'A valid task body2',task_date: Date.current)
        # task2.save!

        expect(task2).to_not be_valid
        expect(task2.errors).to be_present
        expect(task2.errors.to_hash.keys).to include(:name)

        task2.name = 'A different task name'
        expect(task2).to be_valid
      end

      it '3. Is not valid without a body' do
        # task = category.tasks.new(category_id: Category.last.id, name:'A valid task name', body:nil,task_date: Date.current)
        task.body = nil

        expect(task).to_not be_valid
        expect(task.errors).to be_present
        expect(task.errors.to_hash.keys).to include(:body)

        task.body = 'A valid task body'
        expect(task).to be_valid
      end

      it '4. Is not valid without a date' do
        task.task_date = nil
        # task = category.tasks.new(category_id: Category.last.id, name:'A valid task name', body:'A valid task body',task_date: nil)

        expect(task).to_not be_valid
        expect(task.errors).to be_present
        expect(task.errors.to_hash.keys).to include(:task_date)

        task.task_date = Date.current
        expect(task).to be_valid
      end

      it '5. Is not valid when name has less than 3 characters' do
        # task.name = 'a' * 5
        task = category.tasks.new(category_id: Category.last.id, name:'a' * 2, body:'A valid task body',task_date: Date.current)
        
        expect(task).to_not be_valid
        expect(task.errors).to be_present
        expect(task.errors.to_hash.keys).to include(:name)

        task.name = 'a' * 3
        expect(task).to be_valid
      end 

      it '6. Is not valid when body has less than 10 characters' do
        # task.body = 'a' * 9
        task = category.tasks.new(category_id: Category.last.id, name:'A valid name', body:'a' * 9 ,task_date: Date.current)
        
        expect(task).to_not be_valid
        expect(task.errors).to be_present
        expect(task.errors.to_hash.keys).to include(:body)

        task.body = 'a' * 10
        expect(task).to be_valid
      end 

      it '7. Is not valid when body has more than 50 characters' do
        # task.body = 'a' * 51
        task = category.tasks.new(category_id: Category.last.id, name:'A valid name', body:'a' * 51 ,task_date: Date.current)
        
        expect(task).to_not be_valid
        expect(task.errors).to be_present
        expect(task.errors.to_hash.keys).to include(:body)

        task.body = 'a' * 50
        expect(task).to be_valid
      end
    end
end
