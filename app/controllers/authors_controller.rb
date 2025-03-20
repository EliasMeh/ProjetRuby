class AuthorsController < ApplicationController
  def index
    @authors = Author.includes(:books)
  end

  def show
    @author = Author.find(params[:id])
  end

  def new
    @author = Author.new
  end

  def edit
    @author = Author.find(params[:id])
  end
end
