class UsersController < ApplicationController
    def show
        @user = User.find(params[:id])
        @friendship = Friendship.new
        @feed = Post.order(created_at: :desc).where(user_id: params[:id])
        @comment = Comment.new
        @like = Like.new
    end
end
