require 'rails_helper'

RSpec.describe User do
  
  let(:dan) { FactoryBot.create :user }
  let(:mark) { FactoryBot.create :user }
  let(:pablo) { FactoryBot.create :user  } 
  let(:current_user) { dan } 
  let(:friendship_1) { FactoryBot.create(:friendship, friend_invite_id: dan.id, invited_friend_id: mark.id )  }
  let(:friendship_2) { FactoryBot.create(:friendship, friend_invite_id: dan.id, invited_friend_id: pablo.id, accepted: true) } 
  
  
  describe "validation" do
      it "email and passwotd don't be blank" do
        @user = build(:user, email: nil, password: nil, password_confirmation: nil)
      @user.valid?
      expect(@user.errors.count).to eql(2)
      end
      
      it "password too short" do
        @user = build(:user, password: "merci")
        @user.valid?
        expect(@user.errors[:password]).to eql(["is too short (minimum is 6 characters)"])
      end

      it "password confirmation is different" do
        @user = build(:user, password: "merci1234", password_confirmation: "1234merci")
        @user.valid?
        expect(@user.errors[:password_confirmation]).to eql(["doesn't match Password"])  
      end
  end

  describe "Methods Friends" do
    it "invitation?: should return if the user has invitations" do
      friendship_1
      expect(mark.invitations?).to eql(true)  
    end

    it "get_friendship_id: should return friendship id between two users, only if exist a invitation or friendship" do
      current_user = dan
      expect(current_user.get_friendship_id(mark)).to eql(current_user.get_friendship_id(mark))  
    end

    it "has_invited: should return true if the current user has invited another user " do
      friendship_1
      expect(current_user.has_invited?(mark)).to eql(true)  
    end

    it "invitation?: return true if exist an invitation between users" do
      friendship_1
      expect(current_user.invitation?(mark)).to eql(true)  
    end
    
    it "friendship?:return true already exists a friendship with user" do
      friendship_2
      expect(current_user.friendship?(pablo)).to eql(true)  
    end

    it "number_friends return number of friends for each user" do
      friendship_2
      expect(dan.number_friends).to eql(1)  
    end   
  end

  


end #RSPEC END
