require 'active_record'
require 'sqlite3'

# Configuration de la base de données SQLite
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'library.db'
)

# Méthode pour supprimer la base de données (en supprimant le fichier SQLite)
def reset_database
  if File.exist?('library.db')
    File.delete('library.db')
    puts "Database 'library.db' deleted."
  end
end

# Modèle Author avec relation 'has_many' et suppression automatique des livres
class Author < ActiveRecord::Base
  has_many :books, dependent: :destroy
end

# Modèle Book avec relation 'belongs_to' vers Author
class Book < ActiveRecord::Base
  belongs_to :author
end

# Création des tables si elles n'existent pas
def create_tables
  ActiveRecord::Schema.define do
    create_table :authors do |t|
      t.string :name
    end

    create_table :books do |t|
      t.string :title
      t.date :publication_date
      t.references :author, foreign_key: true
    end
  end
  puts "Tables created."
end

# Ajout d'un auteur et de ses livres
def add_author_and_books(name, books)
  author = Author.create(name: name)
  books.each do |book|
    Book.create(title: book[:title], publication_date: book[:publication_date], author: author)
  end
  puts "Author '#{name}' created successfully with books."
end

# Affichage des auteurs et leurs livres
def list_authors_and_books
  Author.includes(:books).each do |author|
    puts "Author: #{author.name}"
    author.books.each do |book|
      puts "  Book: #{book.title}, Published: #{book.publication_date}"
    end
  end
end

# Mise à jour de l'auteur et du livre
def update_author_and_book(author_id, new_name, book_id, new_title, new_publication_date)
  author = Author.find_by(id: author_id)
  if author
    author.update(name: new_name)
    book = author.books.find_by(id: book_id)
    if book
      book.update(title: new_title, publication_date: new_publication_date)
      puts "Author and Book updated."
    else
      puts "Book not found."
    end
  else
    puts "Author not found."
  end
end

# Suppression d'un auteur et de ses livres associés
def delete_author(id)
  author = Author.find_by(id: id)
  if author
    # Rails supprime automatiquement les livres grâce à 'dependent: :destroy'
    author.destroy
    puts "Author '#{author.name}' and their books have been deleted."
  else
    puts "Author not found."
  end
end

# Réinitialisation de la base de données et création des tables
reset_database
create_tables

# Exemple d'utilisation :

# Ajout d'un auteur avec des livres
add_author_and_books("George Orwell", [
  { title: "1984", publication_date: "1949-06-08" },
  { title: "Animal Farm", publication_date: "1945-08-17" }
])

# Affichage des auteurs et livres
list_authors_and_books
