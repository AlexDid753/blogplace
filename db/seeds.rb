# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
posts_number = 200
ratings_number = posts_number*2
ip_addresses  = []
users = []
#айпишиники
50.times do
  ip_addresses.push(Faker::Internet.ip_v4_address)
end


#юзеры(авторы)
99.times do |n|
  login = "login#{n}"
  users.push(login)
  User.create(login: login)
end

#посты
posts_number.times do
  ip_address = ip_addresses.sample
  title = Faker::Book.title
  text = Faker::Lorem.paragraph(2, false, 4)
  login = users.sample
  Post.create(ip_address: ip_address,
              title: title,
              text: text,
              login: login)
end


#оценки
ratings_number.times do
  post_id = rand(1..posts_number)
  rating_value = rand(1..5)
  Rating.create(post_id: post_id,
              rating_value: rating_value)
end

