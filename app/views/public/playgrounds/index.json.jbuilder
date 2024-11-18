json.data do
  json.playground_image do
    json.array!(@playgrounds) do |playground|
      json.id playground.id
      json.user do
        json.name playground.user.nickname
        json.image url_for(playground.user.avatar_image)
      end
      json.image url_for(playground.playground_image)
      json.playground_name playground.name
      json.description playground.description
      json.address playground.address
      json.latitude playground.latitude
      json.longitude playground.longitude
    end  
  end
end