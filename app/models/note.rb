class Note < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :note_comments, dependent: :destroy

  validates :body, presence: { message: '何か書いてみましょう💭' }

  def self.search(keyword)#titleかbodyで検索キーワードが部分一致する投稿を取得する
  where(["title like? OR body like?", "%#{keyword}%", "%#{keyword}%"])
  end
end
