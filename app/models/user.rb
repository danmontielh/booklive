class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook]

  has_many :friendships, foreign_key: "friend_invite_id", class_name: "Friendship"
  has_many :invited_friend, through: :friendships, source: :invited_friend 
  has_many :invites_friend, class_name: "Friendship", foreign_key: "invited_friend_id"
  has_many :friends, through: :invites_friend, source: :friend_invite



  def get_friendship_id(user)
    friendships.where(invited_friend_id: user.id).ids
  end

  def has_invited?(user)
    friendships.where(invited_friend_id: user.id ).where(accepted:false).count == 1
  end

  def friends?(user)
    friendships.where(invited_friend_id: user.id ).where(accepted:true).count == 1
  end

  def invitations
    invites_friend.where(accepted: false)
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
