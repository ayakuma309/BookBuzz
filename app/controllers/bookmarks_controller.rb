class BookmarksController < ApplicationController
  def index
    @bookmark_books = current_user.bookmarks.includes(:book)
  end

  def create
    @book = Book.find_by(isbn: params[:book_isbn])
    current_user.bookmarks.create!(book: @book)
    redirect_to request.referer
  end

  def destroy
    @book = Book.find_by(isbn: params[:book_isbn])
    bookmark = current_user.bookmarks.find_by!(book: @book)
    bookmark.destroy!
    redirect_to request.referer
  end
end
