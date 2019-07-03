class UsersController < ApplicationController
    def show
        @user = User.find(params[:id])
        @num_friends = @user.number_friends
        @friendship = Friendship.new
        @user_invitations = current_user.invitations
        
    end
end
