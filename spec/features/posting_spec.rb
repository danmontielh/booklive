require 'rails_helper'

RSpec.feature "Postings", type: :feature do
  let(:dan) { FactoryBot.create :user, name: "dan" }

  scenario "User create a post and see it" do
    visit root_path
    fill_in "login_email", with: dan.email
    fill_in "login_password",	with: dan.password
    click_on "Log in" 
    click_link "New Post"
    fill_in "Title",	with: "Hello Sample Post"
    fill_in "Content", with: "Sample Content" 
    click_on "Post"
    visit root_path
    expect(page).to  have_content("Hello Sample Post")
  end



end
