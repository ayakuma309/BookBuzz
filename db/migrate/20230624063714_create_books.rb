class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table "books", id: false do |t|
      t.bigint :isbn, primary_key: true
      t.string :title
      t.string :author
      t.text :sales_date
      t.text :large_image_url
      t.text :item_url
      t.text :item_caption
      t.timestamps
    end
  end
end
