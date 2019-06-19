class FriendshipsController < ApplicationController
    def create
        @friendship = current_user.friendships.build(friendship_params)
        if @friendship.save
            flash[:success] = "Invitation has sending !"
            render json: @friendship
        end
    end
    
    private

    def friendship_params
        params.require(:friendship).permit(:invited_friend_id)
    end 
    

end
