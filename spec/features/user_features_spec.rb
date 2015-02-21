require 'rails_helper'
require 'restaurant'
require 'review'

feature 'User' do
  context "user not signed in and on the homepage" do
    it "should see a sign in link and a sign up link" do
      visit('/')
      expect(page).to have_link('Sign in')
      expect(page).to have_link('Sign up')
    end

    it "should not see sign out link" do
      visit '/'
      expect(page).not_to have_link('Sign out')
    end
  end

  context "user signed in on the homepage" do
    
    before do
      visit '/'
      click_link 'Sign up'
      fill_in('Email', with: 'test@example.com')
      fill_in('Password', with: 'testtest')
      fill_in('Password confirmation', with: 'testtest')
      click_button('Sign up')
    end

    it "should see sign out link" do
      visit '/'
      expect(page).to have_link('Sign out')
    end

    it "should not see a sign in link and a sign up link" do
      visit '/'
      expect(page).not_to have_link('Sign in')
      expect(page).not_to have_link('Sign up')
    end
  end 


  context "users should be logged in" do
    before do
      Restaurant.create(name: 'KFC')
    end

    it "should not let someone who is not logged in create a restaurant" do
      visit '/'
      click_link 'Add a restaurant'
      expect(page).to have_content 'Log in'
    end

    it "should not let someone who is not logged in leave a review" do
      visit '/'
      click_link 'Review KFC'
      expect(page).to have_content 'Log in'
    end

  end

  context 'changing restaurant data' do

    before do
      visit '/'
      click_link 'Sign up'
      fill_in('Email', with: 'test@example.com')
      fill_in('Password', with: 'testtest')
      fill_in('Password confirmation', with: 'testtest')
      click_button('Sign up')
      Restaurant.create(name: 'KFC')
      click_link('Sign out')
      click_link 'Sign up'
      fill_in('Email', with: 'alt_test@example.com')
      fill_in('Password', with: 'alt_test')
      fill_in('Password confirmation', with: 'alt_test')
      click_button('Sign up')
    end

    it 'a user should not be able to edit a restaurant created by another user' do
      visit '/'
      click_link 'Edit KFC'
      expect(page).to have_content "You cannot edit this restaurant"
      expect(page).to have_content "KFC"
    end

    it 'a user should not be able to delete a restaurant created by another user' do
      visit '/'
      click_link 'Delete KFC'
      expect(page).to have_content 'You cannot delete this restaurant'
      expect(page).to have_content 'KFC'
    end
  end

  context 'reviewing restaurants' do
    before do
      visit '/'
      click_link 'Sign up'
      fill_in('Email', with: 'test@example.com')
      fill_in('Password', with: 'testtest')
      fill_in('Password confirmation', with: 'testtest')
      click_button('Sign up')
      Restaurant.create(name: 'KFC')
    end

    it 'a user can only leave one review per restaurant' do
      visit '/'
      click_link 'Review KFC'
      fill_in "Thoughts", with: "so so"
      select '3', from: 'Rating'
      click_button 'Leave Review'
      click_link 'Review KFC'
      expect(page).to have_content 'You have already reviewed this restaurant'
      expect(page).not_to have_content 'Thoughts'
    end

    it 'a user can only delete a review that they created' do
      visit '/'
      click_link 'Review KFC'
      fill_in "Thoughts", with: "so so"
      select '3', from: 'Rating'
      click_button 'Leave Review'
      click_link 'Sign out'
      click_link 'Sign up'
      fill_in('Email', with: 'alt_test@example.com')
      fill_in('Password', with: 'alt_test')
      fill_in('Password confirmation', with: 'alt_test')
      click_button('Sign up')
      click_link 'Delete Review'
      expect(page).to have_content 'You cannot delete this review'
      expect(page).to have_content 'so so'
    end
  end
end
