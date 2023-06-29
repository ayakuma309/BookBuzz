class BooksController < ApplicationController
  skip_before_action :require_login, only: %i[index  genres_search]

  def index
    @books = Book.order('RANDOM()').limit(3)
    @twitter_text = Book.generate_twitter_links(@books)
  end

  def show
    @book = Book.find_by(isbn: params[:isbn])
    if @book.author
      @books = RakutenWebService::Books::Book.search(author: @book.author)
    else
      @books = []
      flash.now[:notice] = t('books.search.empty')
    end
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

  def search
    if params[:search]
      @books = RakutenWebService::Books::Book.search(title: params[:search])
    else
      @books = []
      flash.now[:notice] = t('books.search.empty')
    end
  end

  def bookmarks
    @bookmark_books = current_user.bookmarks.includes(:book)
  end

  def genres_search
    if params[:genre_id]
      page_number = rand(1..5)
      @books = RakutenWebService::Books::Book.search(booksGenreId: params[:genre_id], page: page_number)
    else
      @books = []
      flash.now[:notice] = t('books.search.empty')
    end
  end

  def recommends
    @recommend_books_with_same_tags = Book.recommend_books(current_user)
    @recommend_books_with_different_tags = Book.recommend_books_with_different_tags(current_user)
  end

  private
  def book_params
    params.permit(:title, :author, :sales_date, :large_image_url, :item_url, :isbn, :item_caption)
  end
end
