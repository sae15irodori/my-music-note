class AddTagIdToNotes < ActiveRecord::Migration[6.1]
  def change
    add_column :notes, :tag_id, :integer, foreign_key: true
  end
end
