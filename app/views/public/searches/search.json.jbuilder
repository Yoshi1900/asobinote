json.data do
  json.playgrounds do
    json.array!(@playgrounds) do |playground|
      json.id playground.id
      json.playground_name playground.name
      json.description playground.description
      json.address playground.address
      json.latitude playground.latitude
      json.longitude playground.longitude
      json.detail_page_url Rails.application.routes.url_helpers.playground_path(playground)

      # 最初の3枚の画像を取得
      json.playground_images do
        if playground.playground_images.attached?
            json.array!(playground.playground_images.limit(3)) do |image|
            json.url Rails.application.routes.url_helpers.rails_blob_url(image, only_path: true)
          end
        else
          json.array!([]) # 画像がない場合は空配列を返す
        end
      end
    end  
  end
end