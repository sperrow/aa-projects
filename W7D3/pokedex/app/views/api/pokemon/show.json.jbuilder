json.set! :pokemon do
  json.extract! @pokemon, :id, :name, :attack, :defense, :image_url, :moves, :poke_type
end

json.set! :items do
  @pokemon.items.each do |item|
    json.extract! item, :id, :name, :pokemon_id, :price, :happiness, :image_url
  end
end
