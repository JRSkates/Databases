require_relative 'lib/database_connection'
require_relative 'lib/recipes_directory'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('music_library')