class NoteComment < ApplicationRecord
  belongs_to :user
  belongs_to :note

  validates :comment, presence: { message: '' }
  
  def self.ransackable_attributes(auth_object = nil)
    ["comment", "created_at", "id", "note_id", "updated_at", "user_id"]
  end
end
