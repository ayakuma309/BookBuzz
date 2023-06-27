class Admin::BooksController < Admin::BaseController

  def index
    @books = Book.all
  end

  def destroy
    book = Book.find_by(isbn: params[:isbn])
    book.delete
    redirect_to admin_books_path, danger: t('admin.books.destroy.success'), status: :see_other
  end
end
