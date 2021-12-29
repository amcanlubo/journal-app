require 'rails_helper'

RSpec.describe 'Categories', type: :feature do

    before(:each) do
        User.destroy_all
        sign_in create(:user)    
        Category.destroy_all
        Category.create(name:'Category 1')
        
    end

    # let!(:category) { Category.create(name:'Category 1')}

    describe 'View all Categories' do
        
        it 'shows all categories in index page' do
            visit categories_path
            
            expect(page).to have_content 'Categories'
            expect(page).to have_content('No category yet.')
            expect(page).to have_content('See Tasks for today')
        end
    end

    # describe 'Create new Article' do
    #     before { visit articles_path }
    #     it 'Successfully create new article' do
    #     #    visit articles_path
    #             expect(page).to have_content 'New Article'
    #             click_button 'New Article'
    #             expect(page).to have_current_path new_article_path
    #             # expect(response).to redirect_to(new_article_path)
    #             expect(page).to have_content 'Create New Article'
   
    #             within 'form' do
    #                 fill_in 'Name', with: 'Sample name'
    #                 fill_in 'Body', with: 'Sample body'
    #                 click_button 'Create new article'
    #             end
    #         expect(page).to have_current_path articles_path
    #     end
    # end
end

