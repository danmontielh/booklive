require 'rails_helper'

RSpec.describe Post do
  let(:dan) { FactoryBot.create :user }

  describe "Association" do
    it {  should belong_to(:user) }
  end

  describe "validations" do
    it "title and content is blank" do
      @post = build(:post, user_id: dan.id, title: nil, content: nil)
      @post.valid?
      expect(@post.errors.count).to eql(2)  
    end
  end
  
  
end
