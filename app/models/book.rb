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
end
