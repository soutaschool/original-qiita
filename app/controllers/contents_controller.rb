class ContentsController < ApplicationController
    before_action :authenticate_user!
    def new
        @content = Content.new
    end
    def create
        @content = Content.new(content_params)
        @content.user_id = current_user.id
        if @content.save
        redirect_to content_path(@content)
        else 
        render 'new'
        end
    end
    def index
        # カミナリの実装をするので以下の変数に変える
        @contents = Content.page(params[:page]).reverse_order

        if params[:title].present?
            @content = Content.where('name LIKE ?', "%#{params[:title]}%")
        else
            @content = Content.none
        end
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

    def search
        @content = Content.where('title LIKE ?', "%#{params[:title]}%")
    end

    def edit
        @content = Content.find(params[:id])
    end

    def update
        @content = Content.find(params[:id])
        @content.update(content_params)
        redirect_to content_path(@content.id)
    end

    private
    def content_params
        params.require(:content).permit(:title, :tag, :body)
    end
end
