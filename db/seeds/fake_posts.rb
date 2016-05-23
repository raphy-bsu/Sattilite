(1..20).each do |n|
  Post.create(title: Faker::Name.title, body: Faker::Lorem.paragraphs.join)
end
