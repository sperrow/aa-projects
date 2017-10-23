# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
u1 = User.create(username: "Dude")
u2 = User.create(username: "Man")
u3 = User.create(username: "Bro")
u4 = User.create(username: "Pizzaman")

a1 = Artwork.create(title: "pizza", image_url: "pizza", artist_id: 1)
a2 = Artwork.create(title: "fruit", image_url: "fruit.jpg", artist_id: 1)
a3 = Artwork.create(title: "picture", image_url: "pizza.png", artist_id: 2)
a4 = Artwork.create(title: "image", image_url: "image.image.com/image", artist_id: 2)

ArtworkShare.create(viewer_id: 1, artwork_id:3)
ArtworkShare.create(viewer_id: 1, artwork_id:2)
ArtworkShare.create(viewer_id: 3, artwork_id:1)
ArtworkShare.create(viewer_id: 3, artwork_id:2)
ArtworkShare.create(viewer_id: 4, artwork_id:4)
