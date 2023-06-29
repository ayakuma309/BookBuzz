class CreateBookTags < ActiveRecord::Migration[7.0]
  def change
    create_table :book_tags do |t|
      t.references :tag, foreign_key: true
      t.bigint :book_isbn, null: false
      t.timestamps
    end

    add_foreign_key :book_tags, :books, column: :book_isbn, primary_key: 'isbn'
    add_index :book_tags, :book_isbn
    # 同じタグを２回保存するのは出来ないようになる
    add_index :book_tags, [:tag_id, :book_isbn], unique: true
  end
end
