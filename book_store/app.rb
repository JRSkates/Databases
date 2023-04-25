# file: app.rb

require_relative 'lib/database_connection'
require_relative 'lib/book_repository'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('book_store')

book_repo = BookRepository.new

book_repo.all.each do |book|
  puts "#{book.id} - #{book.title} - #{book.author_name}"
end

# results :
# 1 - Nineteen Eighty-Four - George Orwell
# 2 - Mrs Dalloway - Virginia Woolf
# 3 - Emma - Jane Austen
# 4 - Dracula - Bram Stoker
# 5 - The Age of Innocence - Edith Wharton
