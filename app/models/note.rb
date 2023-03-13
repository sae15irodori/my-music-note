class Note < ApplicationRecord
  belongs_to :user
  belongs_to :tag, optional: true
  has_many :favorites, dependent: :destroy
  has_many :note_comments, dependent: :destroy

  has_one_attached :image

  validates :title, presence: { message: '何か書いてみましょう💭' }
  validates :body, presence: { message: '' }

  def favorited_by?(user)#favoritesﾃｰﾌﾞﾙにuser.idが存在するか判定するﾒｿｯﾄﾞ
    favorites.exists?(user_id: user.id)
  end

  def self.search(keyword)#titleかbodyで検索キーワードが部分一致する投稿を取得する
  where(["title like? OR body like?", "%#{keyword}%", "%#{keyword}%"])
  end
end
