class Tag < ApplicationRecord
  has_many :notes, dependent: :destroy
end
