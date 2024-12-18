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

testuser = User.find_or_create_by!(email: "a@a") do |user|
  user.nickname = "testuser"
  user.password = "123456"
  user.phone_number = "1234567890"
  user.introduction = "かわいいもの好き"
  user.avatar_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/avatar1.jpg"), filename:"avatar1.jpg")
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
  playground.post_code = "9300151"
  playground.address = "富山県富山市古沢254"
  playground.phone_number = "3214567891"
  playground.latitude ="36.69213308"
  playground.longitude ="137.1486898"
end

Playground.find_or_create_by!(name: "せん動物園") do |playground|
  playground.user_id = User.all.sample.id
  playground.playground_images = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/playground2.jpg"), filename:"playground2.jpg")
  playground.description = "美しい動物園"
  playground.post_code = "9390362"
  playground.address = "富山県射水市黒河4474-6"
  playground.phone_number = "8792163214"
  playground.latitude ="36.6939415"
  playground.longitude ="137.100595"
end

Playground.find_or_create_by!(name: "魚川ファインモール") do |playground|
  playground.user_id = User.all.sample.id
  playground.playground_images = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/playground3.jpg"), filename:"playground3.jpg")
  playground.description = "定期的に様々なイベントを行っているショッピングモール"
  playground.post_code = "9392716"
  playground.address = "富山県富山市婦中町下轡田165-1"
  playground.phone_number ="4863161841"
  playground.latitude ="36.662442"
  playground.longitude ="137.1712519"
end
Playground.find_or_create_by!(name: "青空スポーツ公園") do |playground|
  playground.user_id = User.all.sample.id
  playground.playground_images = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/playground4.jpg"), filename: "playground4.jpg")
  playground.description = "スポーツが楽しめる広大な公園"
  playground.post_code = "9300805"
  playground.address = "富山県富山市湊入船町12-1"
  playground.phone_number = "3456789123"
  playground.latitude ="36.7068194"
  playground.longitude ="137.2140741"
end

Playground.find_or_create_by!(name: "星の子ミュージアム") do |playground|
  playground.user_id = User.all.sample.id
  playground.playground_images = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/playground5.jpg"), filename: "playground5.jpg")
  playground.description = "家族で楽しめる科学博物館"
  playground.post_code = "9360021"
  playground.address = "富山県滑川市中川原410"
  playground.phone_number = "9876543210"
  playground.latitude ="36.7741045"
  playground.longitude ="137.3443626"
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
  playground.post_code = "9308510"
  playground.address = "富山県富山市新桜町7-38"
  playground.phone_number = "1233681890"
  playground.latitude ="36.695952"
  playground.longitude ="137.213677"
end

20.times do
  Post.find_or_create_by!(title: ["楽しかったね", "最高の思い出", "また行きたい！", "素晴らしい場所", "最高のロケーション", "心が癒されました", "家族で楽しめました", "感動の景色", "おすすめスポット"].sample) do |post|
    post.user_id = User.all.sample.id
    post.playground_id = Playground.all.sample.id
    random_image = "post#{rand(1..12)}.jpg"
    post.post_images = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/#{random_image}"), filename: random_image)
    post.body = ["見渡す限りのきれいな風景で楽しかったね", "一日中遊べて大満足！", "子どもも大人も楽しめる場所でした。", "自然に囲まれてリフレッシュできました。", "アクセスも良く、また行きたいと思いました。", "とても綺麗で癒されました。", "家族で思い出をたくさん作れました。", "夜景もきれいで素敵な時間を過ごせました。", "広々としていてゆったり過ごせました。"].sample
    post.star = rand(0..10) * 0.5
  end
end

tag_names = [
  "子供", "子供と楽しい", "デート向き", "男同士で行きたい", "女子会", "わいわい楽しい", "静かに楽しむ", "ゆったり過ごす",
  "アウトドア好き", "インドア派", "ロマンチック", "リラックス", "冒険心をくすぐる", "家族連れ", "カップルにおすすめ",
  "仲間と一緒に", "大自然を満喫", "都会の喧騒から離れて", "文化を感じる", "芸術に触れる", "音楽を楽しむ", "映画鑑賞",
  "スポーツ観戦", "ゲームが好き", "食事を楽しむ", "スイーツ巡り", "おしゃれカフェ", "歴史を感じる", "ショッピング好き",
  "散歩を楽しむ", "夜景スポット", "自然とのふれあい", "ビーチでリラックス", "温泉に浸かる", "キャンプを楽しむ",
  "登山好き", "リフレッシュ", "感動体験", "刺激的な場所", "和やかな雰囲気", "静かで落ち着く", "冒険心がある", "観光名所",
  "レジャーに最適", "アクティビティ充実", "リゾート気分", "健康志向", "アウトドアスポット", "インドアで安心", "和の雰囲気",
  "洋風テイスト", "家族で安心", "友達と気軽に", "恋人と過ごす", "ユニークな体験", "観光におすすめ", "地域に根付く",
  "週末のお出かけ", "アートな空間", "自然豊か", "リラックスできる", "わいわいできる", "子連れに優しい", "一人で楽しむ",
  "友人と気軽に", "冬の楽しみ", "夏にぴったり", "春の自然を楽しむ", "秋の景色が綺麗", "アドベンチャー", "歴史的建造物",
  "温かみのある場所", "カジュアルな雰囲気", "本格派", "安らぎの空間", "ペットと楽しむ", "インスタ映え", "絶景ポイント",
  "グルメを満喫", "地元の魅力", "四季折々", "風情がある", "現代的な空間", "伝統文化", "楽しい思い出作り", "みんなでワイワイ",
  "自然体験", "アクティブな日々", "美しい景色", "紅葉スポット", "癒しの場所", "体験型アトラクション", "文化交流", "伝統を学ぶ",
  "地元グルメ", "大人の楽しみ", "快適な環境", "リゾート感", "海の幸を堪能", "山の幸を味わう", "地元の食材", "エキサイティング"
]

# タグデータの作成
tag_names.each do |name|
  Tag.find_or_create_by!(name: name)
end

puts "100個のタグデータが作成されました！"

50.times do
  playground = Playground.all.sample
  tag = Tag.all.sample
  
  # 中間テーブルにレコードを作成（重複を避ける）
  unless Tagging.exists?(playground_id: playground.id, tag_id: tag.id)
    Tagging.create!(playground_id: playground.id, tag_id: tag.id)
  end
end

  50.times do
    post = Post.all.sample
    tag = Tag.all.sample
  
    # 中間テーブルにレコードを作成（重複を避ける）
    unless PostTagging.exists?(post_id: post.id, tag_id: tag.id)
      PostTagging.create!(post_id: post.id, tag_id: tag.id)
    end
  end

puts "seedの実行が完了しました"