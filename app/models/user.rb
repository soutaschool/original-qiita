class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
        # ユーザー名
         has_many :contents, dependent: :destroy
         has_many :comments, dependent: :destroy
         has_many :favorites, dependent: :destroy
        # ユーザーの写真を使用するもの
         attachment :profile_image

          validates :name, presence: true
          validates :email, presence: true
          validates :password, length: { minimum: 6 }, on: :create
          validates :password_confirmation, presence: true, on: :create
        
end
