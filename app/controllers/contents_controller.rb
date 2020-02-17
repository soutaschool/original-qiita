class ContentsController < ApplicationController
    def new
        @content = Content.new
    end
    def create
        @content = Content.new(content_params)
        @content.user_id = current_user.id
        if @content.save
        redirect_to contents_path
        else 
        render 'new'
        end
    end
    def index
        # カミナリの実装をするので以下の変数に変える
        @contents = Content.page(params[:page]).reverse_order
    end
    def show
        @content = Content.find(params[:id])
        @comment = Comment.new
    end

    def destroy
        @content = Content.find(params[:id])
        @content.destroy
        redirect_to contents_path
    end

    private
    def content_params
        params.require(:content).permit(:title, :tag, :body)
    end
end
