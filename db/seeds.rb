# Clear existing records
puts "Clearing database..."
Book.destroy_all
Author.destroy_all

# Seed authors and books
puts "Seeding database..."
author = Author.create!(name: "George Orwell")
author.books.create!(title: "1984", publication_date: "1949-06-08")
author.books.create!(title: "Animal Farm", publication_date: "1945-08-17")

puts "Seeding completed!"
puts "Authors: #{Author.count}, Books: #{Book.count}"
