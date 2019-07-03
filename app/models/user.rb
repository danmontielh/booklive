class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook]

  has_many :friendships, foreign_key: "friend_invite_id", class_name: "Friendship"
  has_many :invited_friend, through: :friendships, source: :invited_friend 
  has_many :invites_friend, class_name: "Friendship", foreign_key: "invited_friend_id"
  has_many :friends, through: :invites_friend, source: :friend_invite



  def invitations
    invites_friend.where(accepted: false)
  end
  
  
  def get_friendship_id(user)
    if self.friendships.where(invited_friend_id: user).count == 1
      friendships.where(invited_friend_id: user).ids
    elsif self.invites_friend.where(friend_invite_id: user).count == 1
      invites_friend.where(friend_invite_id: user).ids
    end
  end

  def has_invited?(user)
    friendships.where(invited_friend_id: user.id ).where(accepted:false).count == 1
  end

  

  def invitation?(user)
    if self.invites_friend.where(friend_invite_id: user).where(accepted: false).count == 1
      return true
    elsif self.friendships.where(invited_friend_id: user).where(accepted: false).count == 1
      return true
    else 
      return false
    end
  end

  def friendship?(user)
    if self.invites_friend.where(friend_invite_id: user).where(accepted: true).count == 1
      return true
    elsif self.friendships.where(invited_friend_id: user).where(accepted: true).count == 1
      return true
    else 
      return false
    end
  end

  def number_friends
    total_friends = 0
    number = self.invites_friend.where(accepted: true).count + self.friendships.where(accepted: true).count
    total_friends+=number 
  end
  



  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end

end
