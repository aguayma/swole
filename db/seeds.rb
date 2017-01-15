# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

description = "Are you all right? What's wrong? I felt a great disturbance in the Force...as if millions of
voices suddenly cried out in terror and were suddenly silenced. I fear something terrible has happened.
You'd better get on with your exercises. Well, you can forget your troubles with those Imperial slugs.
Anyway, we should be at Alderaan about oh-two-hundred hours. Now be careful, Artoo. He made a fair move.
Screaming about it won't help you. That's 'cause droids don't pull people's arms out of their socket when
they lose. Wookiees are known to do that. I see your point, sir. I suggest a new strategy, Artoo."

product1 = Product.create(title: '1mo. Crossfit Membership',price: 70,description: description, picture: 'https://s3-us-west-2.amazonaws.com/becasted-static-assets/hackathon+images/crossfit.jpg
')
product2 = Product.create(title: 'Nikes Trainers',price: 40,description: description, picture: 'https://s3-us-west-2.amazonaws.com/becasted-static-assets/hackathon+images/nike-shoes.jpeg')
product3 = Product.create(title: 'P90X Home Workout',price: 40,description: description, picture: 'https://s3-us-west-2.amazonaws.com/becasted-static-assets/hackathon+images/p90x.jpg')
product4 = Product.create(title: 'Adidas Running Shorts',price: 10,description: description, picture: 'https://s3-us-west-2.amazonaws.com/becasted-static-assets/hackathon+images/running-shorts.jpeg')
product5 = Product.create(title: 'Turbo Socks',price: 2,description: description, picture: 'https://s3-us-west-2.amazonaws.com/becasted-static-assets/hackathon+images/socks.png')
product6 = Product.create(title: 'Sport Bottle',price: 5,description: description, picture: 'https://s3-us-west-2.amazonaws.com/becasted-static-assets/hackathon+images/sports-bottle.jpg')
product7 = Product.create(title: 'Head Band',price: 3,description: description, picture: 'https://s3-us-west-2.amazonaws.com/becasted-static-assets/hackathon+images/sweatband.jpg')
product8 = Product.create(title: 'Nike Gym Bag',price: 10,description: description, picture: 'https://s3-us-west-2.amazonaws.com/becasted-static-assets/hackathon+images/gym-bag.jpg')
product9 = Product.create(title: 'Running Pants',price: 20,description: description, picture: 'https://s3-us-west-2.amazonaws.com/becasted-static-assets/hackathon+images/running-pants.jpeg')
product10 = Product.create(title: 'Wind Breaker',price: 40,description: description, picture: 'https://s3-us-west-2.amazonaws.com/becasted-static-assets/hackathon+images/windbreaker.jpg')
