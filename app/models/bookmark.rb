# == Schema Information
#
# Table name: bookmarks
#
#  id         :bigint           not null, primary key
#  book_isbn  :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_bookmarks_on_book_isbn              (book_isbn)
#  index_bookmarks_on_user_id                (user_id)
#  index_bookmarks_on_user_id_and_book_isbn  (user_id,book_isbn) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (book_isbn => books.isbn)
#  fk_rails_...  (user_id => users.id)
#
class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :book, foreign_key: 'book_isbn', primary_key: 'isbn'

  validates :user_id, uniqueness: { scope: :book_isbn }
end
