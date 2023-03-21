class Tag < ApplicationRecord
  has_many :notes, dependent: :destroy

  validates :name, uniqueness: true, presence: { message: '何か書いてみましょう💭' }
  

  def self.ransackable_attributes(auth_object = nil)
    ["name"]
  end
end
