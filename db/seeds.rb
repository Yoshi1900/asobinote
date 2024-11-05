# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Admin.create!(email: "admin@example.jp",
#               password:  "123456",
#               password_confirmation: "123456",)

olivia = User.find_or_create_by!(email: "olivia@example.com") do |user|
  user.nickname = "Olivia"
  user.password = "123456"
  user.phone_number = "06011111111"
  user.introduction = "かわいいもの好き"
  user.avatar_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/avatar1.jpg"), filename:"avatar1.jpg")
end

james = User.find_or_create_by!(email: "james@example.com") do |user|
  user.nickname = "James"
  user.password = "123456"
  user.phone_number = "05011111111"
  user.introduction = "スプラッター好き"
  user.avatar_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/avatar2.jpg"), filename:"avatar2.jpg")
end

lucas = User.find_or_create_by!(email: "lucas@example.com") do |user|
  user.nickname = "Lucas"
  user.password = "123456"
  user.phone_number = "04011111111"
  user.introduction = "探偵もの好き"
  user.avatar_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/avatar3.jpg"), filename:"avatar3.jpg")
end

Playground.find_or_create_by!(name: "大城遊園地") do |playground|
  playground.playground_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/playground1.jpg"), filename:"playground1.jpg")
  playground.description = "大人気の遊園地"
  playground.post_code = "1111111"
  playground.address = "富山県高岡市大城町123-12"
  playground.phone_number = "3214567891"
end

Playground.find_or_create_by!(name: "せん動物園") do |playground|
  playground.playground_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/playground2.jpg"), filename:"playground2.jpg")
  playground.description = "美しい動物園"
  playground.post_code = "2222222"
  playground.address = "富山県富山市戦場ヶ原町233-23"
  playground.phone_number = "8792163214"
end

Playground.find_or_create_by!(name: "魚川ファインモール") do |playground|
  playground.playground_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/splayground3.jpg"), filename:"playground3.jpg")
  playground.description = "定期的に様々なイベントを行っているショッピングモール"
  playground.post_code = "3333333"
  playground.address = "富山県魚川立浪町784-32"
  playground.phone_number ="486316184"