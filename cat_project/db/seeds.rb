# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
cat1 = Cat.create(name: "Bobby", sex: 'F', birth_date: '2015/01/20', color: 'brown', description: 'This cat is brown and has name: Bobby')
cat2 = Cat.create(name: "Marbles", sex: 'M', birth_date: '2015/04/23', color: 'gray', description: 'This cat is gray and has name: Marbles')
cat3 = Cat.create(name: "Francis", sex: 'M', birth_date: '2016/01/20', color: 'black', description: 'This cat is black and has name: Francis')
cat4 = Cat.create(name: "Angelica", sex: 'F', birth_date: '1980/01/20', color: 'orange', description: 'This cat is orange and has a name: Angelica')
