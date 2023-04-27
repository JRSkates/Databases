require_relative 'lib/database_connection'
require_relative 'lib/user_repository'
require_relative 'lib/post_repository'

DatabaseConnection.connect('social_network')

user_repository = UserRepository.new
post_repository = PostRepository.new

user_repository.all.each do |user|
  puts "#{user.id} - #{user.username} - #{user.email}"
end

puts

first = user_repository.find(1)
puts  "#{first.id} - #{first.username} - #{first.email}"

puts

post_repository.all.each do |post|
  puts "#{post.id} - #{post.title} - #{post.content} - #{post.view_count} - #{post.user_id}"
end

puts

fist_post = post_repository.find(3)

puts "#{fist_post.id} - #{fist_post.title} - #{fist_post.content} - #{fist_post.view_count} - #{fist_post.user_id}"