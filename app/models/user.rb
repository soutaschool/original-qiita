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

          acts_as_followable # フォロワー機能
          acts_as_follower   # フォロー機能

          # お知らせ機能
          has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
          has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
   
          def create_notification_follow!(current_user)
            temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
            if temp.blank?
              notification = current_user.active_notifications.new(
                visited_id: id,
                action: 'follow'
              )
              notification.save if notification.valid?
            end
          end
end
