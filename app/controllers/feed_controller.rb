class FeedController < ApplicationController
    before_action :authenticate_user!, only: [:index]
    def index
        @feed = current_user.get_posts
        @comment = Comment.new
        @like = Like.new
        @user = User.find(current_user.id)
        
    end

    
    
end
