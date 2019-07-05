class FeedController < ApplicationController
    before_action :authenticate_user!, only: [:index]
    def index
        @feed = Post.order(created_at: :desc)
        @comment = Comment.new
        @like = Like.new
    end

    
    
end
