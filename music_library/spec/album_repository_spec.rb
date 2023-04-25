require 'album_repository'

RSpec.describe AlbumRepository do

  def reset_artists_table 
    seed_sql = File.read('spec/seeds_albums.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
  end
  
  before(:each) do
    reset_artists_table
  end
  context 'With the all method' do
    it 'returns all 2 albums' do
      repo = AlbumRepository.new #seeded from our test seed with 2 columns
      albums = repo.all 

      expect(albums.length).to eq 2
      expect(albums.first.release_year).to eq '1999'
      expect(albums.first.title).to eq 'Bossanova'
      expect(albums.first.artist_id ).to eq '1'
    end
  end

  context 'With the find method' do
    it 'Returns a single album' do
      repo = AlbumRepository.new 
      album = repo.find(1)

      expect(album.title).to eq 'Bossanova'
      expect(album.release_year).to eq '1999'
      expect(album.artist_id).to eq '1'
      expect(album.id).to eq '1'
    end

    it 'Returns another album' do
      repo = AlbumRepository.new 
      album = repo.find(2)

      expect(album.title).to eq 'Surfer Rosa'
      expect(album.release_year).to eq '2001'
      expect(album.artist_id).to eq '1'
      expect(album.id).to eq '2'
    end
  end
end