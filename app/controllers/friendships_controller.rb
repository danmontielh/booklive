class FriendshipsController < ApplicationController

    before_action :set_friendship, only: [:show, :update, :destroy, :destroy_friendship]


    def create
        @friendship = current_user.friendships.build(friendship_params)
        if @friendship.save
            flash[:success] = "Invitation has sending !"
            @user = User.find(@friendship.invited_friend_id)
            respond_to do |format|
                format.js 
            end
        end
    end

    def update
        @friendship.update_attributes(accepted:true)
        @user = User.find(@friendship.friend_invite_id)
        respond_to do |format|
            format.js 
        end
    end

    def destroy_friendship
        @user = nil
        current_user.id == @friendship.friend_invite_id ? ( @user = User.find(@friendship.invited_friend_id) ) : ( @user = User.find(@friendship.friend_invite_id) )
        if @friendship.destroy
            respond_to do |format|
                format.js 
            end
        end
    end


    def destroy
        @user = User.find(@friendship.invited_friend_id)
        if @friendship.destroy
            flash[:success] = "Invitation has sending !"
            respond_to do |format|
                format.js 
            end
        else

        end
    end




    private

    def set_friendship
        @friendship = Friendship.find(params[:id])
    end

    def friendship_params
        params.require(:friendship).permit(:invited_friend_id)
    end 
    

end
