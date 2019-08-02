require 'rails_helper'

RSpec.feature "Comments", type: :feature do
  let(:dan) { FactoryBot.create :user, name: "dan" }


  it "User can comment on post" do
    visit root_path
    fill_in "login_email", with: dan.email
    fill_in "login_password",	with: dan.password
    click_on "Log in" 
    post = create(:post, user_id: dan.id)
    visit current_path
    expect(page).to have_content("Comments")  
    comment = create(:comment, user_id: dan.id, post_id: post.id, body: "Comment sample")
    visit current_path
    expect(page).to  have_content("Comment sample")
  end
  

end
