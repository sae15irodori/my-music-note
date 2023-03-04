class Note < ApplicationRecord
  belongs_to :user, optional: true
  has_many :favorites, dependent: :destroy
  has_many :note_comments, dependent: :destroy

  validates :body, presence: { message: '何か書いてみましょう💭' }
end
