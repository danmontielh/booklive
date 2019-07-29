class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook]

  has_many :friendships, foreign_key: "friend_invite_id", class_name: "Friendship"
  has_many :invited_friend, through: :friendships, source: :invited_friend 
  has_many :invites_friend, class_name: "Friendship", foreign_key: "invited_friend_id"
  has_many :friends, through: :invites_friend, source: :friend_invite 
  has_many :posts
  has_many :comments
  has_many :likes
  has_one_attached :avatar

  after_create :welcome_mail
  


  def invitations?
    invites_friend.not_accepted.count > 0
  end
  
  
  def get_friendship_id(user)
    if self.friendships.has_invited(user).count == 1
      friendships.has_invited(user).ids
    elsif self.invites_friend.has_invitation(user).count == 1
      invites_friend.has_invitation(user).ids
    end
  end

  def has_invited?(user)
    friendships.has_invited(user).count == 1
  end

  

  def invitation?(user)
    if self.invites_friend.has_invitation(user).not_accepted.count == 1
      return true
    elsif self.friendships.has_invited(user).not_accepted.count == 1
      return true
    else 
      return false
    end
  end

  def friendship?(user)
    if self.invites_friend.has_invitation(user).accepted.count == 1
      return true
    elsif self.friendships.has_invited(user).accepted.count == 1
      return true
    else 
      return false
    end
  end

  def friends
    ids = []
    user_has_invitation = self.invites_friend.accepted.each {| friend |   ids.push(friend.friend_invite_id) } 
    user_has_invitated = self.friendships.accepted.each {| friend |   ids.push(friend.invited_friend_id) } 
      return ids
  end


  def get_posts
    friends = self.friends.join(", ")
    if self.friends.count > 0
      Post.timeline_friends(friends, self)
    else
      Post.timeline_only(self)
    end
  end


  def number_friends
    total_friends = 0
    number = self.invites_friend.accepted.count + self.friendships.accepted.count
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


  def welcome_mail
    UserMailer::welcome_email(self).deliver
  end

end
