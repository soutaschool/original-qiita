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
        @contents = Content.published.order("created_at DESC").page(params[:page]).per(10)

        if params[:title].present?
            @content = Content.where('name LIKE ?', "%#{params[:title]}%")
        else
            @content = Content.none
        end
    end
    def show
        @comment = Comment.new
        @content = Content.find(params[:id])

        if  @content.nil?
        redirect_to root_path
        elsif @content.draft?
        login_required
        end
        # 条件分岐で下書きはログインしてないと見れなくする
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

    def confirm
        @user = User.find(params[:id])
        @contents = @user.contents.draft.order("created_at DESC").page(params[:page]).per(10)
        # ユーザーの投稿した下書きを閲覧することができるようになる
    end

    def timeline
    end

    private
    def content_params
        params.require(:content).permit(:title, :tag, :body, :status, :image)
    end

    def login_required
        redirect_to login_url unless current_user
    end
end
