class ContentsController < ApplicationController
    def new
        @content = Content.new
    end
    def create
        @content = Content.new(content_params)
        @content.user_id = current_user.id
        @content.save
        redirect_to contents_path
    end
    def index
        @contents = Content.all
    end
    def show
        @content = Content.find(params[:id])
        @comment = Comment.new
    end

    private
    def content_params
        params.require(:content).permit(:title, :tag, :body)
    end
end
