class CreateNotes < ActiveRecord::Migration[6.1]
  def change
    create_table :notes do |t|
      t.string :title
      t.text :body, null: false
      t.string :movie
      t.timestamps
    end
  end
end
