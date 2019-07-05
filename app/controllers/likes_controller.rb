class LikesController < ApplicationController 

    def create
        @like = current_user.likes.build(like_params)
       # @like.user_id = current_user
        if @like.save
            redirect_to  feed_index_path
        end
    end

    private 

    def like_params
        params.require(:like).permit(:post_id)
    end
    
end