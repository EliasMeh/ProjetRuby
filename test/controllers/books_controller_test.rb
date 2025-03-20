require "test_helper"

class BooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @book = books(:one)
    @author = authors(:one)
  end

  test "should get index" do
    get books_url
    assert_response :success
  end

  test "should get show" do
    get book_url(@book)
    assert_response :success
  end

  test "should get new" do
    get new_book_url
    assert_response :success
  end

  test "should get edit" do
    get edit_book_url(@book)
    assert_response :success
  end

  test "should create book" do
    assert_difference("Book.count") do
      post books_url, params: { book: { title: "New Book", author_id: @author.id, publication_date: Date.today } }
    end
    assert_redirected_to book_url(Book.last)
  end

  test "should mark book as taken" do
    patch mark_as_taken_book_url(@book)
    assert_redirected_to book_url(@book)
    @book.reload
    assert_equal "taken", @book.status
  end

  test "should mark book as returned" do
    @book.update(status: "taken")
    patch mark_as_returned_book_url(@book)
    assert_redirected_to book_url(@book)
    @book.reload
    assert_equal "available", @book.status
  end
end
