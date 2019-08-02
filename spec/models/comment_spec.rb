require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:post1) { FactoryBot.create :post }
  let(:dan) { FactoryBot.create :user }


  describe "Association" do
    it { should belong_to(:user) }
    it { should belong_to(:post) }      
  end

  describe "validation" do
    it "content don't be blank " do
      @comment = build(:comment, post_id: post1.id, user_id: dan.id, body: nil )
      @comment.valid?
      expect(@comment.errors.count).to eql(1)  
    end
    
  end
end
