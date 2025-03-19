require "sqlite3"
require "active_record"

# === Database Setup ===
ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: "library.db"
)

# === Define Models ===
class Author < ActiveRecord::Base
  has_many :books
end

class Book < ActiveRecord::Base
  belongs_to :author
end

# === Create Tables (if they don't exist already) ===
ActiveRecord::Schema.define do
  create_table :authors, if_not_exists: true do |t|
    t.string :name
    t.timestamps
  end

  create_table :books, if_not_exists: true do |t|
    t.string :title
    t.date :published_date
    t.references :author, foreign_key: true
    t.timestamps
  end
end

# === CRUD Operations ===

# Author CRUD

def create_author(name)
  Author.create(name: name)
  puts "Author '#{name}' created successfully."
end

def read_author(id)
  author = Author.find_by(id: id)
  if author
    puts "Author: #{author.name}"
    author.books.each { |book| puts "  Book: #{book.title}, Published: #{book.published_date}" }
  else
    puts "Author not found."
  end
end

def update_author(id, new_name)
  author = Author.find_by(id: id)
  if author
    author.update(name: new_name)
    puts "Author updated to '#{new_name}'."
  else
    puts "Author not found."
  end
end

def delete_author(id)
  author = Author.find_by(id: id)
  if author
    author.destroy
    puts "Author '#{author.name}' deleted."
  else
    puts "Author not found."
  end
end

# Book CRUD

def create_book(title, published_date, author_id)
  author = Author.find_by(id: author_id)
  if author
    book = Book.create(title: title, published_date: published_date, author: author)
    puts "Book '#{title}' created successfully."
  else
    puts "Author not found."
  end
end

def read_book(id)
  book = Book.find_by(id: id)
  if book
    puts "Book: #{book.title}, Published: #{book.published_date}, Author: #{book.author.name}"
  else
    puts "Book not found."
  end
end

def update_book(id, new_title, new_published_date)
  book = Book.find_by(id: id)
  if book
    book.update(title: new_title, published_date: new_published_date)
    puts "Book updated to '#{new_title}', Published: #{new_published_date}."
  else
    puts "Book not found."
  end
end

def delete_book(id)
  book = Book.find_by(id: id)
  if book
    book.destroy
    puts "Book '#{book.title}' deleted."
  else
    puts "Book not found."
  end
end

# === Example Usage ===
create_author("George Orwell")
author = Author.last
create_book("1984", "1949-06-08", author.id)
create_book("Animal Farm", "1945-08-17", author.id)

read_author(author.id)
read_book(1)

update_author(author.id, "Orwell, George")
update_book(1, "1984 (Updated Edition)", "1950-06-08")

delete_book(2)
delete_author(author.id)
