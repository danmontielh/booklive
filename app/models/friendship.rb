class Friendship < ApplicationRecord
    belongs_to :friend_invite, class_name: "User"
    belongs_to :invited_friend, class_name: "User"

    attr_readonly :invited_friend_id, :invited_friend_id

    scope :not_accepted, -> { where(accepted: false) }
    scope :accepted, -> { where(accepted: true) }
    scope :has_invited, ->(user) {  where(invited_friend_id: user) }
    scope :has_invitation, ->(user) { where(friend_invite_id: user) }

    validate :is_invitation?, on: :create


    def is_invitation?
        query = [ "friend_invite_id = #{friend_invite_id} AND invited_friend_id =  #{invited_friend_id} OR friend_invite_id = #{invited_friend_id} AND invited_friend_id =  #{friend_invite_id}"]
        errors.add(:error1,"Invitation already exists") if Friendship.where(query).exists?
    end
    

end

