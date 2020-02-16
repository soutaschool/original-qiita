class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
        # ユーザー名
         has_many :contents, dependent: :destroy
         has_many :comments, dependent: :destroy
         has_many :favorites, dependent: :destroy
end
