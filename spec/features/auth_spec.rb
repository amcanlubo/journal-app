require 'rails_helper'
# new_user_session_path
# user_session_path

RSpec.describe 'Auth', type: :feature do

    before(:each) do
        User.destroy_all
        Category.destroy_all
        # User.create!(email:'amcblog@email.com', password:'password', password_confirmation:'password')
    end

    # let!(:user) { User.create(email:'amcblog@email.com', password:'password', password_confirmation:'password') }

    # describe 'Unauthenticated user' do
        context '1. As a User, I want to create my account so that I can have my own credentials' do
            
            it 'renders a form to create an account' do
                visit new_user_registration_path

                expect(page).to have_content('Sign up')
                expect(page).to have_content('Log in')
            end

            it 'succesfully creates user account' do
                visit new_user_registration_path
                
                within 'form' do
                    fill_in 'Email', :with =>'amcblog@email.com'
                    fill_in 'Password', :with => 'password'
                    fill_in 'Password confirmation', with: 'password'
                    click_button 'Sign up'
                end
                
                # expect(page).to have_text("Welcome! You have signed up successfully.")
                expect(page).to have_content('amcblog@email.com')
                expect(page).to have_content('Categories')
                expect(page).to have_content('No category yet.')
                expect(page).to have_content('See Tasks for today')
            end

            it 'does not allow blank user input' do
                visit new_user_registration_path

                within 'form' do
                    fill_in 'Email', :with => nil
                    fill_in 'Password', :with => nil
                    fill_in 'Password confirmation', with: nil
                    click_button 'Sign up'
                end
 
                expect(page).to have_content('Email can\'t be blank')
                expect(page).to have_content('Password can\'t be blank')
            end

            it 'does not allow invalid email input' do
                visit new_user_registration_path

                within 'form' do
                    fill_in 'Email', :with => 'asdafsd.com'
                    fill_in 'Password', :with => 'password'
                    fill_in 'Password confirmation', with: 'password'
                    click_button 'Sign up'
                end

                expect(page).to have_content('Email is invalid')
            end

            it 'does not allow duplicate email input' do
                
                User.create(email:'amcblog@email.com', password:'password', password_confirmation:'password') 
                
                visit new_user_registration_path

                within 'form' do
                    fill_in 'Email', :with => 'amcblog@email.com'
                    fill_in 'Password', :with => 'password'
                    fill_in 'Password confirmation', with: 'password'
                    click_button 'Sign up'
                end
                
                expect(page).to have_content('Email has already been taken')
            end

            it 'does not allow mismatch password' do
                visit new_user_registration_path
                within 'form' do
                    fill_in 'Email', :with => 'amcblog@email.com'
                    fill_in 'Password', :with => 'password'
                    fill_in 'Password confirmation', with: 'passwOOOD'
                    click_button 'Sign up'
                end
                
                expect(page).to have_content('Password confirmation doesn\'t match Password')
                
            end

            it 'does not allow invalid password length' do
                visit new_user_registration_path
                within 'form' do
                    fill_in 'Email', :with => 'amcblog@email.com'
                    fill_in 'Password', :with => 'pass'
                    fill_in 'Password confirmation', with: 'pass'
                    click_button 'Sign up'
                end
                
                expect(page).to have_content("Password is too short (minimum is 6 characters)")
               
            end
        end
    # end

        context '2. As a User, I want to login my account so that I can access my account and link my own tasks' do
            
            let!(:user) { User.create(email:'amcblog@email.com', password:'password', password_confirmation:'password') }

            it 'allows authenticated access' do
                visit new_user_session_path

                within 'form' do
                    fill_in 'Email', :with =>'amcblog@email.com'
                    fill_in 'Password', :with => 'password'
                    click_button 'Log in'
                end
                
                # expect(page).to have_text("Signed in successfully.")
                expect(page).to have_content('amcblog@email.com')
                expect(page).to have_content('Categories')
                expect(page).to have_content('No category yet.')
                expect(page).to have_content('See Tasks for today')
            end

            it "blocks unauthenticated access" do   
                
                visit new_user_session_path

                within 'form' do
                    fill_in 'Email', :with => nil
                    fill_in 'Password', :with => 'passadfgr'
                    click_button 'Log in'
                end
               
                expect(page).to have_current_path user_session_path
                expect(page).to have_content('Sign in')
                expect(page).to have_content('Sign up')
                expect(page).to_not have_content('Signed in successfully.')
            end
        end
end