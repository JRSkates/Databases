require_relative './album'

class AlbumRepository
  def all
    sql = 'SELECT id, title, release_year, artist_id FROM albums'
    result_set = DatabaseConnection.exec_params(sql, [])
     # result_set is a PG::Result object which is an array 
     # of hashes one hash per row in the result set
     albums_array = []

     result_set.each do |record|
       album = Album.new
       album.id = record['id']
       album.title = record['title']
       album.release_year = record['release_year']
       album.artist_id = record['artist_id']

       albums_array << album
     end

     return albums_array

  end

  def find(id)
    # Executes the SQL query:
    # SELECT id, title, release_year, artist_id FROM albums WHERE id = $1;
    sql = 'SELECT id, title, release_year, artist_id FROM albums WHERE id = $1;'
    param = [id]

    result = DatabaseConnection.exec_params(sql, param)

    # Returns a single Album object.
    record = result[0]
    album = Album.new
    album.id = record['id']
    album.title = record['title']
    album.release_year = record['release_year']
    album.artist_id = record['artist_id']

    return album
  end

end
