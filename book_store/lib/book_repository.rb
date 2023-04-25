require_relative 'book'

class BookRepository

    # Selecting all records
    # No arguments
  def self.all
    sql = 'SELECT id, title, author_name FROM books'
    result_set = DatabaseConnection.exec_params(sql, [])

    books_array = []

    result_set.each do |record|
      book = Book.new

      book.id = record['id']
      book.title = record['title']
      book.author_name = record['author_name']

      books_array << book
    end
  
    return books_array
  end
end