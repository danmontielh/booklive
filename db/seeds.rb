# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

 25.times do
     User.create([{   
         name: Faker::Name.name,
        email: Faker::Internet.free_email, 
         password: 123456789
        }])
 end

 50.times do
     Post.create([{
         title: Faker::Lorem.sentence,
         content: Faker::Lorem.paragraph(2),
        user_id: (rand*25).ceil
     }])
 end

 25.times do
     Friendship.create([{
         friend_invite_id: (rand*25).ceil ,
         invited_friend_id: (rand*25).ceil ,
         accepted: [true,false].sample
     }])
 end


 100.times do
     Comment.create([{
         body: Faker::Lorem.paragraph(2),
         post_id: (rand*50).ceil,
         user_id: (rand*25).ceil
     }])
 end

100.times do
    Like.create([{
        post_id: (rand*50).ceil,
        user_id: (rand*25).ceil
    }])
end