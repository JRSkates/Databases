require 'book_repository'

RSpec.describe BookRepository do
  
  def reset_artists_table 
    seed_sql = File.read('spec/seeds_books.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'book_store_test' })
    connection.exec(seed_sql)
  end
    
  before(:each) do
    reset_artists_table
  end

  it 'returns list of books' do
   repo = BookRepository.new #seeded from our test seed with 1 column

   books = repo.all 
   expect(books.length).to eq 1
   expect(books.first.title).to eq 'Nineteen Eighty-Four'
   expect(books.first.author_name).to eq 'George Orwell'
  end
end