require_relative 'artist'

class ArtistRepository
  def all 
    sql = 'SELECT id, name, genre FROM artists;'
    result_set = DatabaseConnection.exec_params(sql, [])

    artists_array = []

    result_set.each do |record|
      artist = Artist.new
      artist.id = record['id']
      artist.name = record['name']
      artist.genre = record['genre']

      artists_array << artist
    end

    return artists_array
  end

  def find(id)
    sql = 'SELECT id, name, genre FROM artists WHERE id = $1;'
    param = [id]

    result = DatabaseConnection.exec_params(sql, param)

    record = result[0]
    artist = Artist.new
    artist.id = record['id']
    artist.name = record['name']
    artist.genre = record['genre']
    
    return artist
  end

end