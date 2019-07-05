class ApplicationController < ActionController::Base

    def like?(post_id)
        @like = current_user.likes.where(post_id: post_id).count
        return true if @like > 0
    end
    
end
