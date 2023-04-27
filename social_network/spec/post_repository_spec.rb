require 'post_repository'

RSpec.describe PostRepository do

  def reset_artists_table 
    seed_sql = File.read('spec/seeds_posts.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
    connection.exec(seed_sql)
  end
  
  before(:each) do
    reset_artists_table
  end
  
  context 'With the All Method' do
    it 'returns all posts in the database' do
      repo = PostRepository.new 
      posts = repo.all 

      expect(posts.length).to eq 3
      expect(posts.first.title).to eq 'Jacks Trip to the Zoo'
      expect(posts.last.title).to eq 'How I scored a goal'
      expect(posts.first.content).to eq 'I saw a penguin it was great'
    end
  end

  context 'With the Find Method' do
    it 'returns a specific post in the database based on its id' do
      repo = PostRepository.new
      post = repo.find(1)

      expect(post.id).to eq '1'
      expect(post.title).to eq 'Jacks Trip to the Zoo'
      expect(post.content).to eq 'I saw a penguin it was great'
      expect(post.view_count).to eq '15'
      expect(post.user_id).to eq '1'
    end
  end

  context 'With the Create Method' do
    it 'creates a new post and adds it to the database' do
      repo = PostRepository.new
      post = Post.new
      post.title = 'My Story'
      post.content = 'I dont have a story yet'
      post.view_count = 0
      post.user_id = '1'

      repo.create(post)
      posts = repo.all
      last_post = posts.last

      expect(last_post.id).to eq '4'
      expect(last_post.title).to eq 'My Story'
      expect(last_post.content).to eq 'I dont have a story yet'
      expect(last_post.view_count).to eq '0'
      expect(last_post.user_id).to eq '1'
    end
  end

  context 'With the Delete method' do
    it 'deletes the post from the database at the specified id' do
      repo = PostRepository.new  
      repo.delete(1)
      
      posts = repo.all
      first_post = posts.first
      
      expect(first_post.id).to eq '2'
      expect(first_post.title).to eq 'Title coming soon'
      expect(first_post.content).to eq 'Content also coming soon'
      expect(first_post.view_count).to eq '4'
      expect(first_post.user_id).to eq '2'
    end
  end

  context 'With the Update method' do
    it 'updates the post in the database' do
      repo = PostRepository.new  
      original_post = repo.find(1)
      
      original_post.title = 'I went BACK to the ZOO'
      original_post.content = 'All the penguins were gone :('
      original_post.view_count = 0
      
      repo.update(original_post)
      
      updated_post = repo.find(1)
      
      expect(updated_post.title).to eq 'I went BACK to the ZOO'
      expect(updated_post.content).to eq 'All the penguins were gone :('
      expect(updated_post.view_count).to eq '0'
      expect(updated_post.user_id).to eq '1'
    end
  end
end
