# == Schema Information
#
# Table name: books
#
#  author          :string
#  isbn            :bigint           not null, primary key
#  item_caption    :text
#  item_url        :text
#  large_image_url :text
#  sales_date      :text
#  title           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Book < ApplicationRecord
  self.primary_key = :isbn

  has_many :bookmarks, foreign_key: 'book_isbn', primary_key: 'isbn', dependent: :destroy
  has_many :book_tags, foreign_key: 'book_isbn', dependent: :destroy
  has_many :tags, through: :book_tags

  validates :isbn, uniqueness: { scope: :isbn }

  def save_with(tag_ids)
    ActiveRecord::Base.transaction do
      self.tags = tag_ids.map { |id| Tag.find(id) }
      save!
    end
    true
  rescue StandardError
    false
  end

  def self.generate_twitter_links(books)
    encoded_share_text = books.map { |book| "#{book.author} : #{book.title}%0a" }
    encoded_share_text.join.html_safe
  end

  def bookmark?(user)
    bookmarks.where(user_id: user.id).exists?
  end

  # ユーザーがブックマークした本のタグを分析し、同じ種類のタグを持つ本を推薦するメソッド
  def self.recommend_books(user)
    # ユーザーがブックマークした本の配列を取得
    bookmarked_books = user.bookmarks.includes(:book).map(&:book)
    # ブックマークした本のタグの収集（重複を除く）
    bookmarked_tags = bookmarked_books.flat_map(&:tags).uniq


    recommended_books = []
    all_books = Book.all # 全ての本の取得

    all_books.each do |book|
      next if bookmarked_books.include?(book) # ブックマークした本は除外

      #ブックマークした本以外の本のタグ
      book_tags = book.tags

      # 類似度の計算(ブックマークした本のタグ, ブックマークした本以外の本のタグ)
      similarity = calculate_similarity(bookmarked_tags, book_tags)

      recommended_books << { book: book, similarity: similarity }
    end

    # 類似度で降順ソート
    recommended_books.sort_by! { |b| b[:similarity] }.reverse!
    # 上位5件の本のリストを返す
    recommended_books.take(5).map { |b| b[:book] }
  end

  # タグの類似度を計算するメソッド
  def self.calculate_similarity(bookmarked_tags, book_tags)
    # タグリストが空の場合は類似度を0とする
    return 0 if bookmarked_tags.empty? || book_tags.empty?

    #共通タグの取得
    common_tags = bookmarked_tags & book_tags
    # 共通タグの数をもとに共通タグの割合を算出し類似度を計算
    similarity = common_tags.size.to_f / (bookmarked_tags.size + book_tags.size - common_tags.size)

    similarity
  end

  # ユーザーがブックマークした本のタグを分析し、違う種類のタグを持つ本を推薦するメソッド
  def self.recommend_books_with_different_tags(user)
    # ユーザーがブックマークした本の取得
    bookmarked_books = user.bookmarks.includes(:book).map(&:book)
    # ブックマークした本のタグの収集（重複を除く）
    bookmarked_tags = bookmarked_books.flat_map(&:tags).uniq
    # ブックマークした本のタグ以外のタグを持つ本を取得
    recommended_books = Book.joins(:tags).where.not(tags: { id: bookmarked_tags.to_a.map(&:id) }).distinct
    recommended_books
  end
end
