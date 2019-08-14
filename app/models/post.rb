class Post < ApplicationRecord 
  belongs_to :user
  has_many :comments
  has_many :likes
  has_one_attached :photo

  validates :title, presence: true
  validates :content, presence: true


  def like?(user)
    likes.where(user_id: user.id).count > 0
  end

  def total_likes
    likes.count
  end


  def self.timeline_friends(list_friends, id)
    where("user_id IN (#{list_friends}) OR user_id = #{id}").order(created_at: :desc)
  end

  def self.timeline_only(id)
    where("user_id = #{id}").order(created_at: :desc)
  end

end
