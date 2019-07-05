class UsersController < ApplicationController
    def show
        @user = User.find(params[:id])
        @num_friends = @user.number_friends
        @friendship = Friendship.new
    end
end
