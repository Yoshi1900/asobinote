json.data do
  json.playgrounds do
    json.array!(@playgrounds) do |playground|
      json.id playground.id
      json.user do
        json.name playground.user&.nickname
      end
      json.playground_name playground.name
      json.description playground.description
      json.address playground.address
      json.latitude playground.latitude
      json.longitude playground.longitude
    end  
  end
end