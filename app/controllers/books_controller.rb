class BooksController < ApplicationController
  skip_before_action :require_login, only: %i[index]

  def index
    @books = Book.order('RANDOM()').limit(3)
  end

  def show
    @book = Book.find_by(isbn: params[:isbn])
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: t('books.create.success') }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    book = Book.find_by(isbn: params[:isbn])
    book.delete
    redirect_to books_path, danger: t('books.destroy.success'), status: :see_other
  end

  def search
    if params[:search]
      @books = RakutenWebService::Books::Book.search(title: params[:search])
    else
      @books = []
      flash.now[:notice] = t('books.search.empty')
    end
  end

  private
  def book_params
    params.permit(:title, :author, :sales_date, :large_image_url, :item_url, :isbn, :item_caption)
  end
end
