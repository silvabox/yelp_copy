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


context "things only users should be able to do" do
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
