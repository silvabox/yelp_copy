require 'rails_helper'
require 'restaurant'
require 'review'

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
    click_link 'Add a restaurant'
    fill_in 'Name', with: 'KFC'
    click_button 'Create Restaurant'
    click_button('Sign out')
    click_link 'Sign up'
    fill_in('Email', with: 'alt_test@example.com')
    fill_in('Password', with: 'alttest')
    fill_in('Password confirmation', with: 'alttest')
    click_button('Sign up')
  end

  it 'a user should not be able to edit a restaurant created by another user' do
    click_link 'Edit KFC'
    fill_in 'Name', with: 'Kentucky Fried Chicken'
    click_button 'Update Restaurant'
    expect(page).not_to have_content 'Kentucky Fried Chicken'
  end

  it 'a user should not be able to delete a restaurant created by another user' do
    click_link 'Delete KFC'
    expect(page).to have_content 'KFC'
  end
end
