class AddUrlToNotes < ActiveRecord::Migration[6.1]
  def change
    add_column :notes, :url, :string
  end
end
