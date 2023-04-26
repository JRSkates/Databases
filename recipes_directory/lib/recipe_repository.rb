require_relative 'recipe'

class RecipeRepository
  def all
    sql = 'SELECT id, dish_name, average_cooking_time, rating FROM recipes;'
    result = DatabaseConnection.exec_params(sql, [])

    recipes_array = []

    result.each do |row|
      recipe = Recipe.new
      recipe.id = row['id']
      recipe.dish_name = row['dish_name']
      recipe.average_cooking_time = row['average_cooking_time']
      recipe.rating = row['rating']

      recipes_array << recipe
    end

    return recipes_array
  end

  def find(id)
    sql = 'SELECT id, dish_name, average_cooking_time, rating FROM recipes WHERE id = $1;'
    sql_params = [id]
    result = DatabaseConnection.exec_params(sql, sql_params)

    record = result.first
    recipe = Recipe.new
    recipe.id = record['id']
    recipe.dish_name = record['dish_name']
    recipe.average_cooking_time = record['average_cooking_time']
    recipe.rating = record['rating']

    return recipe
  end
end