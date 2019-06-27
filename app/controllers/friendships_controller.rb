class FriendshipsController < ApplicationController




    def create
        @friendship = current_user.friendships.build(friendship_params)
        if @friendship.save
            flash[:success] = "Invitation has sending !"
            respond_to do |format|
                format.js { render 'users/create' }
            end
        end
    end
    
    private

    def friendship_params
        params.require(:friendship).permit(:invited_friend_id)
    end 
    

end
