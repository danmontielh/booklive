class UsersController < ApplicationController
    def show
        @user = User.find(params[:id])
        @friendship = Friendship.new
        
    end
end
