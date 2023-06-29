# == Schema Information
#
# Table name: book_tags
#
#  id         :bigint           not null, primary key
#  book_isbn  :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  tag_id     :bigint
#
# Indexes
#
#  index_book_tags_on_book_isbn             (book_isbn)
#  index_book_tags_on_tag_id                (tag_id)
#  index_book_tags_on_tag_id_and_book_isbn  (tag_id,book_isbn) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (book_isbn => books.isbn)
#  fk_rails_...  (tag_id => tags.id)
#
class BookTag < ApplicationRecord
  belongs_to :tag
  belongs_to :book, foreign_key: 'book_isbn', primary_key: 'isbn'

end
