require_relative 'lib/database_connection'
require_relative 'lib/recipe_repository'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('recipes_directory')

recipes_repository = RecipeRepository.new

puts "All Method:"
recipes_repository.all.each do |recipe|
  puts "#{recipe.id} - #{recipe.dish_name} - #{recipe.average_cooking_time} - #{recipe.rating}"
end

puts "Find Method"
recipe_single = recipes_repository.find(2)

puts "#{recipe_single.id} - #{recipe_single.dish_name} - #{recipe_single.average_cooking_time} - #{recipe_single.rating}"