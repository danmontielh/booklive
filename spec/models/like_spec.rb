require 'rails_helper'

RSpec.describe Like, type: :model do
  describe "association" do
    it { should belong_to(:post) }  
    it { should belong_to(:user) } 
  end

  describe "create a like" do
    it "create a like for a post" do
      @user = create(:user)
      @post = create(:post)
      @like = create(:like, user_id: @user.id, post_id: @post.id)
    expect(@like.valid?).to eql(true)
    end
    

  end
  
  
end
