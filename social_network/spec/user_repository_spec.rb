require 'user_repository'

RSpec.describe UserRepository do

  def reset_artists_table 
    seed_sql = File.read('spec/seeds_users.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_artists_table
  end
  
  context "With the All Method" do
    it 'returns all the users' do
      repo = UserRepository.new  
      users = repo.all 

      expect(users.length).to eq 3
      expect(users.first.id).to eq '1'
      expect(users.first.username).to eq 'JackSkates'
      expect(users.first.email).to eq 'jack@gmail.com'
      expect(users.last.username).to eq 'FrankLampard'
    end
  end

  context 'With the Find Method' do
    it 'returns the user matching the id provided' do
      repo = UserRepository.new  
      user = repo.find(1)

      expect(user.id).to eq '1'
      expect(user.username).to eq 'JackSkates'
      expect(user.email).to eq 'jack@gmail.com'
    end
  end

  context 'With the Create Method' do
    it 'confirms that created users are added to the database' do
      repo = UserRepository.new  
      user = User.new
      user.username = 'TimRoberts1'
      user.email = 'tim@timtim.com'
          
      repo.create(user)
      user = repo.all
      last_user = user.last
      
      expect(last_user.id).to eq '4'
      expect(last_user.username).to eq 'TimRoberts1'
      expect(last_user.email).to eq 'tim@timtim.com'
    end
  end

  context 'With the Delete Method' do
    it 'confirms that deleted users are removed from the database' do
      repo = UserRepository.new  
      repo.delete(1)
      
      users = repo.all
      first_user = users.first
      
      expect(first_user.id).to eq '2'
      expect(first_user.username).to eq 'JaneDoe1'
      expect(first_user.email).to eq 'janedoe@gmail.com'
    end
  end

  context 'With the Update Method' do
    it 'confirms that the user is updated' do
      repo = UserRepository.new  
      original_user = repo.find(1)
      
      original_user.username = 'xXSkatesXx'
      original_user.email = 'superskates420@coolnet.com'
      
      repo.update(original_user)
      
      updated_user = repo.find(1)
      
      expect(updated_user.username).to eq 'xXSkatesXx'
      expect(updated_user.email).to eq 'superskates420@coolnet.com'
    end
  end
end