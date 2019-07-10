class UsersController < ApplicationController


    def index
        @users = User.all
        @friendship = Friendship.new
    end


    def show
        @user = User.find(params[:id])
        @num_friends = @user.number_friends
        @friendship = Friendship.new
        @feed = Post.order(created_at: :desc).where(user_id: params[:id])
        @comment = Comment.new
        @like = Like.new
    end
end
