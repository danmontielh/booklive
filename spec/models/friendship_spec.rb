require 'rails_helper'

RSpec.describe Friendship, type: :model do
    let(:dan) { FactoryBot.create :user }
    let(:mark) { FactoryBot.create :user }
    let(:pablo) { FactoryBot.create :user  } 
    let(:current_user) { dan } 
   
    
    describe "Request friendship, accept Friendship and valid" do
        it "Friendship request" do
            @friendship = build(:friendship, friend_invite_id: dan.id, invited_friend_id: mark.id)
            expect(@friendship.valid?).to eql(true)  
        end
        it "Is there friendship?" do
            @friendship2 = build(:friendship, friend_invite_id: dan.id, invited_friend_id: pablo.id, accepted: true)
            expect(@friendship2.accepted).to eql(true)  
        end
        
    end
    

  end
  