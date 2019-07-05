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
            redirect_to  feed_index_path
        end
    end

    def destroy
        @comment = @post.comments.find(params[:id])
    
        if @comment.user_id == @current_user_id
          @comment.destroy
          render json: {}
        else
          render json: { errors: { comment: ['not owned by user'] } }, status: :forbidden
        end
    end
  
    private
  

    def comment_params
        params.require(:comment).permit(:body)
    end

end