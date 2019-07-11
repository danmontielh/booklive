class Post < ApplicationRecord 
  belongs_to :user
  has_many :comments
  has_many :likes
  has_one_attached :photo

  validates :title, presence: true
  validates :content, presence: true
  
  
end
