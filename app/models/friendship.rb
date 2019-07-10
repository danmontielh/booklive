class Friendship < ApplicationRecord
    belongs_to :friend_invite, class_name: "User"
    belongs_to :invited_friend, class_name: "User"

    scope :not_accepted, -> { where(accepted: false) }
    scope :accepted, -> { where(accepted: true) }
    scope :has_invited, ->(user) {  where(invited_friend_id: user) }
    scope :has_invitation, ->(user) { where(friend_invite_id: user) }


end

