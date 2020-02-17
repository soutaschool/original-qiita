class UsersController < ApplicationController
    def show
        @user = User.find(params[:id])
        # 投稿したユーザーの作品を表示
        @contents = @user.contents.page(params[:page]).reverse_order  
    end

end