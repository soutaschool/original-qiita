class UsersController < ApplicationController
    def show
        @user = User.find(params[:id])
        # 投稿したユーザーの作品を表示
        @contents = @user.contents.page(params[:page]).reverse_order  
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        @user.update(user_params)
        redirect_to user_path(@user.id)
    end

    private 
    def user_params
        params.require(:user).permit(:first_name, :last_name, :profile_image,
         :check_email, :site, :company, :from, :introduction)
    end
end