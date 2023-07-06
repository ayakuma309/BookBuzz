class StaticPagesController < ApplicationController
  skip_before_action :require_login

  MAX_GENRES = 6
  
  def top; end

  def recommend_genre
    response = RakutenWebService::Books::Genre.search(booksGenreId: Rails.configuration.bookGenreId)
    @genres = response.first.children.take(MAX_GENRES)
  end

  def terms; end

  def privacy; end
end
