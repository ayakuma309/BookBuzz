class CreateBookmarks < ActiveRecord::Migration[7.0]
  def change
    create_table :bookmarks do |t|
      t.references :user, null: false, foreign_key: true
      t.bigint :book_isbn, null: false

      t.timestamps
    end

    add_foreign_key :bookmarks, :books, column: :book_isbn, primary_key: 'isbn'
    add_index :bookmarks, :book_isbn
    add_index :bookmarks, [:user_id, :book_isbn], unique: true
  end
end
