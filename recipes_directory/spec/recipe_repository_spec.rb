require 'recipe_repository'

RSpec.describe RecipeRepository do
  
  def reset_artists_table 
    seed_sql = File.read('spec/seeds_recipes.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'recipes_directory_test' })
    connection.exec(seed_sql)
  end
    
  before(:each) do
    reset_artists_table
  end
  
  context "with the all method" do
    it 'returns all recipes' do
      repo = RecipeRepository.new #seeded from our test seed with 1 column

      recipes = repo.all
      expect(recipes.first.dish_name).to eq 'Pizza'
      expect(recipes.last.dish_name).to eq 'Steak and Ale Pie'
      expect(recipes.first.average_cooking_time).to eq '12'
      expect(recipes.first.rating).to eq '5'
    end
  end

  context "with the find method" do
    it "returns a single recipe" do
      repo = RecipeRepository.new #seeded from our test seed with 1 column

      recipe = repo.find(1)
      expect(recipe.dish_name).to eq 'Pizza'
      expect(recipe.average_cooking_time).to eq '12'
      expect(recipe.rating).to eq '5'
    end
  end
end