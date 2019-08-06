require 'rails_helper'

RSpec.feature "Friendships", type: :feature do
  
  let(:dan) { FactoryBot.create :user, name: "dan" }
  let(:mark) { FactoryBot.create :user, name: "mark" }

  scenario "Friendship mechanism" do
    visit root_path
    fill_in "login_email", with: dan.email
    fill_in "login_password",	with: dan.password
    click_on "Log in"
    click_link "New Post"
    fill_in "Title",	with: "Hello Second Sample Post"
    fill_in "Content", with: "Sample Second Content" 
    click_on "Post" 
    friendship = create(:friendship, friend_invite_id: dan.id, invited_friend_id: mark.id, accepted: true )
    click_link href: destroy_user_session_path
    fill_in "login_email", with: mark.email
    fill_in "login_password",	with: mark.password
    click_on "Log in"
    visit root_path
    expect(page).to  have_content("Hello Second Sample Post")
  end

end
