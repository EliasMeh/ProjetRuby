class BooksController < ApplicationController
  before_action :set_book, only: [ :show, :edit, :update, :destroy, :mark_as_taken, :mark_as_returned ]

  def index
    @books = Book.all
  end

  def show
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to @book, notice: "Book was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to @book, notice: "Book was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @book.destroy
    redirect_to books_url, notice: "Book was successfully destroyed."
  end

  def mark_as_taken
    @book.update(status: "taken")
    redirect_to @book, notice: "Book marked as taken."
  end

  def mark_as_returned
    @book.update(status: "available")
    redirect_to @book, notice: "Book marked as returned."
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author_id, :publication_date, :status)
  end
end
