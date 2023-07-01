class Admin::BooksController < Admin::BaseController
  before_action :set_book, only: %i[edit update destroy]

  def index
    @books = if params[:search].present?
              Book.where("title LIKE ?", "%#{params[:search]}%").page(params[:page])
            elsif params[:tag_name].present?
              tag = Tag.find_by(name: params[:tag_name])
              tag.books.includes(:tags).order(created_at: :desc).page(params[:page])
            else
              Book.includes(:tags).order(created_at: :desc).page(params[:page])
            end
  end

  def edit; end

  def update
    @book.assign_attributes(book_params)
    if @book.save_with(tag_ids)
      redirect_to admin_books_path, success: t('books.update.success')
    else
      flash.now[:danger] = t('defaults.message.not_created')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @book.delete
    redirect_to admin_books_path, danger: t('books.destroy.success'), status: :see_other
  end

  private
  def book_params
    params.require(:book).permit(:isbn, :title, :author, :sales_date, :large_image_url, :item_url, :item_caption, tag_ids: [])
  end

  def set_book
    @book = Book.find_by(isbn: params[:isbn])
  end

  def tag_ids
    params[:book][:tag_ids].compact_blank
  end
end
