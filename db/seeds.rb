# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])

puts "seedの実行を開始"
Admin.find_or_create_by!(email: "admin@example.jp") do |admin|
  admin.password = "123456"
  admin.password_confirmation = "123456"
end


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
sophia = User.find_or_create_by!(email: "sophia@example.com") do |user|
  user.nickname = "Sophia"
  user.password = "123456"
  user.phone_number = "07011111111"
  user.introduction = "読書好き"
  user.avatar_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/avatar4.jpg"), filename: "avatar4.jpg")
end

liam = User.find_or_create_by!(email: "liam@example.com") do |user|
  user.nickname = "Liam"
  user.password = "123456"
  user.phone_number = "08011111111"
  user.introduction = "映画鑑賞好き"
  user.avatar_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/avatar5.jpg"), filename: "avatar5.jpg")
end

emma = User.find_or_create_by!(email: "emma@example.com") do |user|
  user.nickname = "Emma"
  user.password = "123456"
  user.phone_number = "09011111111"
  user.introduction = "アート好き"
  user.avatar_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/avatar6.jpg"), filename: "avatar6.jpg")
end

Playground.find_or_create_by!(name: "大城遊園地") do |playground|
  playground.user_id = User.all.sample.id
  playground.playground_images = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/playground1.jpg"), filename:"playground1.jpg")
  playground.description = "大人気の遊園地"
  playground.post_code = "1111111"
  playground.address = "富山県高岡市大城町123-12"
  playground.phone_number = "3214567891"
end

Playground.find_or_create_by!(name: "せん動物園") do |playground|
  playground.user_id = User.all.sample.id
  playground.playground_images = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/playground2.jpg"), filename:"playground2.jpg")
  playground.description = "美しい動物園"
  playground.post_code = "2222222"
  playground.address = "富山県富山市戦場ヶ原町233-23"
  playground.phone_number = "8792163214"
end

Playground.find_or_create_by!(name: "魚川ファインモール") do |playground|
  playground.user_id = User.all.sample.id
  playground.playground_images = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/playground3.jpg"), filename:"playground3.jpg")
  playground.description = "定期的に様々なイベントを行っているショッピングモール"
  playground.post_code = "3333333"
  playground.address = "富山県魚川立浪町784-32"
  playground.phone_number ="4863161841"
end
Playground.find_or_create_by!(name: "青空スポーツ公園") do |playground|
  playground.user_id = User.all.sample.id
  playground.playground_images = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/playground4.jpg"), filename: "playground4.jpg")
  playground.description = "スポーツが楽しめる広大な公園"
  playground.post_code = "4444444"
  playground.address = "富山県砺波市青空町456-34"
  playground.phone_number = "3456789123"
end

Playground.find_or_create_by!(name: "星の子ミュージアム") do |playground|
  playground.user_id = User.all.sample.id
  playground.playground_images = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/playground5.jpg"), filename: "playground5.jpg")
  playground.description = "家族で楽しめる科学博物館"
  playground.post_code = "5555555"
  playground.address = "富山県高岡市星町567-45"
  playground.phone_number = "9876543210"
end

Playground.find_or_create_by!(name: "森の遊び場") do |playground|
  playground.user_id = User.all.sample.id
  playground.playground_images = [
    ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/playground6.jpg"), filename: "playground6.jpg"),
    ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/playground7.jpg"), filename: "playground7.jpg"),
    ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/playground8.jpg"), filename: "playground8.jpg"),
    ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/playground8.jpg"), filename: "playground8.jpg")
  ]
  playground.description = "自然と触れ合える遊び場"
  playground.post_code = "6666666"
  playground.address = "富山県黒部市森町123-56"
  playground.phone_number = "1233681890"
end

9.times do
  Post.find_or_create_by!(title: ["楽しかったね", "最高の思い出", "また行きたい！", "素晴らしい場所", "最高のロケーション", "心が癒されました", "家族で楽しめました", "感動の景色", "おすすめスポット"].sample) do |post|
    post.user_id = User.all.sample.id
    post.playground_id = Playground.all.sample.id
    random_image = "post#{rand(1..12)}.jpg"
    post.post_images = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/#{random_image}"), filename: random_image)
    post.body = ["見渡す限りのきれいな風景で楽しかったね", "一日中遊べて大満足！", "子どもも大人も楽しめる場所でした。", "自然に囲まれてリフレッシュできました。", "アクセスも良く、また行きたいと思いました。", "とても綺麗で癒されました。", "家族で思い出をたくさん作れました。", "夜景もきれいで素敵な時間を過ごせました。", "広々としていてゆったり過ごせました。"].sample
    post.star = rand(0..10) * 0.5
  end
end

puts "seedの実行が完了しました"