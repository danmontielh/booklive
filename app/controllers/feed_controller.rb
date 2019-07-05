class FeedController < ApplicationController
    before_action :authenticate_user!, only: [:index]
    def index
        @user = User.find(current_user.id)
        
    end
    
end
