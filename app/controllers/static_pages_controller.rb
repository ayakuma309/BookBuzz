class StaticPagesController < ApplicationController
  skip_before_action :require_login
  def top
    response = RakutenWebService::Books::Genre.search(booksGenreId:'001004')
    @genres = response.first.children.take(6)
  end

  def terms; end

  def privacy; end
end
