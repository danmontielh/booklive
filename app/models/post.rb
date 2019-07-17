class Post < ApplicationRecord 
  belongs_to :user
  has_many :comments
  has_many :likes
  has_one_attached :photo

  validates :title, presence: true
  validates :content, presence: true


  def self.timeline_friends(list_friends, user)
    where("user_id IN (#{list_friends}) OR user_id = #{user.id}").order(created_at: :desc)
  end

  def self.timeline_only(user)
    where("user_id = #{user.id}").order(created_at: :desc)
  end

end
