class FriendshipsController < ApplicationController

    before_action :set_friendship, only: [:show, :update, :destroy]


    def create
        @friendship = current_user.friendships.build(friendship_params)
        if @friendship.save
            flash[:success] = "Invitation has sending !"
            respond_to do |format|
                format.js { render 'users/create', locals: { user: User.find(@friendship.invited_friend_id) }}
            end
        end
    end

    def destroy
        @friendship.destroy
    end
    
    
    private

    def set_friendship
        @friendship = Friendship.find(params[:id])
    end

    def friendship_params
        params.require(:friendship).permit(:invited_friend_id)
    end 
    

end
