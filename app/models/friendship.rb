class Friendship < ApplicationRecord
    belongs_to :friend_invite, class_name: "User"
    belongs_to :invited_friend, class_name: "User"

    scope :not_accepted, -> { where(accepted: false) }


end

