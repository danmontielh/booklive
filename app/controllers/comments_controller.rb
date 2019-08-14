class CommentsController < ApplicationController
    before_action :authenticate_user!, except: [:index]
    # before_action :find_post!

    def new
        
    end
    

    def index
        @comments = @post.comments.order(created_at: :desc)
    end

    def create
        @post = Post.find(params[:comment][:post_id])
        @comment = @post.comments.build(comment_params)
        @comment.user = current_user
        if @comment.save
            respond_to do |format|
                format.js 
            end
        end
    end

  
    private
  

    def comment_params
        params.require(:comment).permit(:body)
    end

end