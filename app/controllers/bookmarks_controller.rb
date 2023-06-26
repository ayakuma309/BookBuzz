class BookmarksController < ApplicationController
  def create
    @book = Book.find_by(isbn: params[:book_isbn])
    current_user.bookmarks.create!(book: @book)
  end

  def destroy
    @book = Book.find_by(isbn: params[:book_isbn])
    bookmark = current_user.bookmarks.find_by!(book: @book)
    bookmark.destroy!
  end
end
