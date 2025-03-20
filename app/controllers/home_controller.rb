class HomeController < ApplicationController
  def index
    @authors = Author.includes(:books)
    @books = Book.all
  end
end
