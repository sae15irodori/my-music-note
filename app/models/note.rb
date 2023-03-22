class Note < ApplicationRecord
  belongs_to :user, optional: true
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

  def self.ransackable_attributes(auth_object = nil)
    ["body", "created_at", "id", "movie", "tag_id", "title", "updated_at", "url", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["favorites", "image_attachment", "image_blob", "note_comments", "tag", "user"]
  end
  
  def self.active_user_notes(tag)
    tag.notes.joins(:user).merge(User.where(is_deleted: false))
  end
end
