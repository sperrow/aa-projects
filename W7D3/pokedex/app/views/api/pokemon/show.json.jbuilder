json.pokemon do
  json.extract! @pokemon, :id, :name, :attack, :defense, :moves, :poke_type
  json.image_url asset_path(@pokemon.image_url)
end

json.items do
  json.array! @pokemon.items do |item|
    json.id item.id
    json.name item.name
    json.price item.price
    json.happiness item.happiness
    json.image_url asset_path(item.image_url)
  end
end
