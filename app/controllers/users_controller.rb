class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :screen_user, only: [:edit, :update]
    def show
        @user = User.find(params[:id])
        # 投稿したユーザーの作品を表示
        @contents = @user.contents.published.page(params[:page]).reverse_order  
    end

    def edit
        @user = User.find(params[:id])
    end

    def index
        @users = User.page(params[:page]).reverse_order

        if params[:name].present?
            @user = User.where('name LIKE ?', "%#{params[:name]}%")
        else
            @user = User.none
        end
    end

    def update
        @user = User.find(params[:id])
        @user.update(user_params)
      	redirect_to user_path(@user)
    end

    def search
          @user = User.where('name LIKE ?', "%#{params[:name]}%")
    end

    def follow
        @user = User.find(params[:user_id])
        current_user.follow(@user)
        @user.create_notification_follow!(current_user)
        redirect_to user_path(@user)
    end
  #フォローする
  
    def unfollow
        @user = User.find(params[:user_id])
        current_user.stop_following(@user)
        redirect_to user_path(@user)
    end
  #フォローを外す
  
  
    def follow_list
      @user = User.find(params[:user_id])
    end
  #フォローしてる人の一覧ページ
  
    def follower_list
      @user = User.find(params[:user_id])
    end
  #フォロワーの一覧ページ

  # ユーザーのアカウントの削除
    def destroy
      @user = User.find(params[:id])
      @user.destroy
      redirect_to root_path
    end

    private 
    def user_params
        params.require(:user).permit(:name, :first_name, :last_name, :profile_image,
         :check_email, :site, :company, :from, :introduction)
    end

    def screen_user
    	unless params[:id].to_i == current_user.id #スクリーンのユーザーかどうかを確かめる
    		redirect_to user_path(current_user)
    	end
    end
end