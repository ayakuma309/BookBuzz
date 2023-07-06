class StaticPagesController < ApplicationController
  skip_before_action :require_login
  def top; end

  def recommend_genre
    response = RakutenWebService::Books::Genre.search(booksGenreId: Rails.configuration.bookGenreId)
    @genres = response.first.children.take(6)
  end

  def terms; end

  def privacy; end
end
