puts "Seeds: start"
CITIES = %w(Bielsko-Biala Bytom Chorzow Gliwice Jastrzebie-Zdroj Jaworzno Katowice
              Myslowice Rybnik Siemianowice Sosnowiec Swietocholowice Tychy Zabrze Zory)
ANNO_TYPE = %w(Lost Find)
ANIMAL = %w(dog cat)
AdminUser.create!(email: 'admin@lostpetfinder.com', password: 'password', password_confirmation: 'password')

8.times do
  User.create!(
    email: Faker::Internet.email,
    password: Faker::Internet.password(8)
  )
end
puts "Users created"

users = User.all

3.times do
  users.each do |user|
    animal = ANIMAL.sample
    announcement = Announcement.create!(
      place: CITIES.sample,
      title: Faker::Lorem.sentence,
      description: Faker::Lorem.paragraph,
      animal: animal,
      anno_type: ANNO_TYPE.sample,
      user_id: user.id,
      avatar: File.new("app/assets/images/"+animal+".jpg")
    )
  end
end
puts "Announcement created"

2..6.times do
  Announcement.all.each do |anno|
    message = anno.messages.create!(
      user_id: users.sample.id,
      content: Faker::Lorem.sentence
    )
  end
end
puts "Messages created"

puts "Seeds: finished"


