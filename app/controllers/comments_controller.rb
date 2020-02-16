class CommentsController < ApplicationController
    def create
        content = Content.find(params[:content_id])
        comment = current_user.comments.new(comment_params)
        comment.content_id = content.id
        comment.save
        redirect_to content_path(content)
    end
    private
    def comment_params
      params.require(:comment).permit(:user_id,:content_id,:comment)
    end
end
