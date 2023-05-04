# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'

# create 100 users
100.times do |index|
  p "Creating User #{ index }"
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    avatar: Faker::Avatar.image,
    bio: Faker::Lorem.sentence,
    username: Faker::Internet.username,
    password: Faker::Internet.password,
    role: :appuser
  )
end

# create posts
user_ids = User.pluck(:id)
500.times do |index|
  p "Creating Post #{ index }"
  Post.create!(
    content: Faker::Lorem.sentence,
    user_id: user_ids.sample
  )
end

# associate images to posts
post_ids = Post.pluck(:id)
800.times do |index|
  p "Creating Image #{index}"
  Image.create!(
    url: Faker::Internet.url,
    post_id: post_ids.sample
  )
end

#likes to posts
2000.times do |index|
  p "Creating Like #{index}"
  Like.create!(
    user_id: user_ids.sample,
    post_id: post_ids.sample
  )
end

#create comments to posts
1000.times do |index|
  p "Creating Comment #{index}"
  Comment.create!(
    user_id: user_ids.sample,
    post_id: post_ids.sample,
    content: Faker::Lorem.sentence
  )
end

#create groups
200.times do |index|
  p "Cresting Group #{ index }"
  ActiveRecord::Base.transaction do
    creator = user_ids.sample
    group = Group.create!(
      name: Faker::Team.name,
      description: Faker::Lorem.sentence,
      image_url: Faker::Avatar.image,
      user_id: creator,
      )
    GroupPermission.create!(user: User.find(creator), group: group, role: :admin)
    3.times do
      group_user = user_ids.sample
      if group_user != creator
        group.users << User.find(group_user)
        GroupPermission.create!(user: User.find(group_user), group: group, role: :member)
      else
        backup = user_ids.sample
        group.users << User.find(backup)
        GroupPermission.create!(user: User.find(backup), group: group, role: :member)
      end
    end
  end
end


#create friendships
users = User.all
friendships = []

500.times do |index|
  p "Creating Friendship #{index}"
  user = users.sample
  friend = users.reject { |u| u == user || user.friendships.include?(u) }.sample
  friendships << { user_id: user.id, friend_id: friend.id, status: 'accepted' }
end

Friendship.create(friendships)


# TODO: CREATE DATA FOR FRIEND REQUESTS MODEL TOO




