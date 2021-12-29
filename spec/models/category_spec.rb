require 'rails_helper'

RSpec.describe Category, type: :model do
  
  before(:each) do 
    Category.destroy_all 
  end

  let!(:category) {Category.new}

  context 'Category Validations' do

    it '1. Creates a category that can be used to organize user tasks' do 
      category.name = 'samplecategory1'
      category.save!

      expect(Category.count).to eq(1)
    end

    it '2. Validates presence of name' do
      category.name = nil

      expect(category).to_not be_valid
      expect(category.errors).to be_present
      expect(category.errors.to_hash.keys).to include(:name)
    
      category.name = 'a valid name'
      expect(category).to be_valid
    end

    it '3. Validates uniqueness of name' do
      category.name = 'A valid name'
      category.save!
      
      new_category = Category.new(name:'A valid name')
      
      expect(new_category).to_not be_valid
      expect(new_category.errors).to be_present
      expect(new_category.errors.to_hash.keys).to include(:name)
      
      new_category.name = 'Unique category name'
      expect(new_category).to be_valid
    end

    it '4. Validates name with at least 3 characters' do
      category.name = 'a' * 2
      
      expect(category).to_not be_valid
      expect(category.errors).to be_present
      expect(category.errors.to_hash.keys).to include(:name)
      
      category.name = 'a' * 3
      expect(category).to be_valid
    end
  
    it '5. Enables the user edit a category to update the category details' do
      category.name = 'A valid name'
      category.update!(name:'A valid name updated')

      expect(category.name).to eq('A valid name updated')
      expect(category).to be_valid
    end

    it '6. Enables the user to view a category to show the category details' do
      category.name = 'A valid name'

      expect(category.name).to eq('A valid name')
    end
  end
end
