class ChatsController < ApplicationController
  def index
    if params[:books]
      client = OpenAiClient.new
      books = params[:books]
      @response = client.chat(books)
    end
  end
end
