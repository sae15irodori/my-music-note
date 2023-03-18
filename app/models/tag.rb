class Tag < ApplicationRecord
  has_many :notes, dependent: :destroy
  
  def self.ransackable_attributes(auth_object = nil)
    ["name"]
  end
end
