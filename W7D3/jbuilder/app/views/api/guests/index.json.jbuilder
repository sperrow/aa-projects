json.array! @guests do |guest|
  json.partial! 'api/guests/guest', guest: guest if guest.age.between?(40, 50)
end
