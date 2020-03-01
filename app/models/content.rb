class Content < ApplicationRecord

    enum status: { draft: 0, published: 1 }
    # 下書きを0に設定し、公開の記事を１にする
    belongs_to :user
    has_many :comments, dependent: :destroy
    has_many :favorites, dependent: :destroy
    validates :title, presence: true
    validates :tag_list, presence: true
    validates :body, presence: true
    def favorited_by?(user)
      favorites.where(user_id: user.id).exists?
    end
    # user.idがfavoriteに存在するかどうか
    attachment :image

    # tagのgemようのモデル
    acts_as_taggable
end
