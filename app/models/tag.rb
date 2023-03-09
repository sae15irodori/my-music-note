class Tag < ApplicationRecord
  has_many :notes, dependent: :destroy
  validates :name, presence: { message: '何か書いてみましょう💭' }
end
