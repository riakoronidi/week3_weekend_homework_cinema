require_relative('models/customer.rb')
require_relative('models/film.rb')
require_relative('models/ticket.rb')
require_relative('models/screening.rb')

require('pry-byebug')

Screening.delete_all()
Ticket.delete_all()
Customer.delete_all()
Film.delete_all()

customer1 = Customer.new({'name' => 'Ria', 'funds' => '50'})
customer1.save()
customer2 = Customer.new({'name' => 'Dora', 'funds' => '80'})
customer2.save()
customer3 = Customer.new({'name' => 'Maria', 'funds' => '40'})
customer3.save()
customer4 = Customer.new({'name' => 'Georgina', 'funds' => '50'})
customer4.save()


film1 = Film.new({'title' => 'The Metrix', 'price' => '10'})
film1.save()
film2= Film.new({'title' => 'Little Women', 'price' => '11'})
film2.save()
film3 = Film.new({'title' => 'Avengers', 'price' => '9'})
film3.save()
film4 = Film.new({'title' => 'Blade', 'price' => '10'})
film4.save()

ticket1 = Ticket.new({'film_id' => film1.id, 'customer_id' => customer1.id})
ticket1.save()
ticket2 = Ticket.new({'film_id' => film2.id, 'customer_id' => customer2.id})
ticket2.save()
ticket3 = Ticket.new({'film_id' => film3.id, 'customer_id' => customer3.id})
ticket3.save()
ticket4 = Ticket.new({'film_id' => film4.id, 'customer_id' => customer4.id})
ticket4.save()
ticket5 = Ticket.new({'film_id' => film4.id, 'customer_id' => customer1.id})
ticket5.save()

screening1 = Screening.new({'screening' => '12:00', 'film_id' => film1.id, 'customer_id' => customer1.id})
screening1.save()
screening2 = Screening.new({'screening' => '17:00', 'film_id' => film2.id, 'customer_id' => customer2.id})
screening2.save()
screening3 = Screening.new({'screening' => '20:00', 'film_id' => film3.id, 'customer_id' => customer3.id})
screening3.save()
screening4 = Screening.new({'screening' => '21:30', 'film_id' => film4.id, 'customer_id' => customer4.id})
screening4.save()
screening5 = Screening.new({'screening' => '20:00', 'film_id' => film4.id, 'customer_id' => customer4.id})
screening5.save()
screening6 = Screening.new({'screening' => '17:00', 'film_id' => film4.id, 'customer_id' => customer4.id})
screening6.save()
screening7 = Screening.new({'screening' => '17:00', 'film_id' => film3.id, 'customer_id' => customer3.id})
screening7.save()
screening8 = Screening.new({'screening' => '17:00', 'film_id' => film3.id, 'customer_id' => customer4.id})
screening8.save()

customer2.name = "Dina"
customer2.update()

film2.title = "P.S. I love you"
film2.update()

p "#{customer1.tickets_bought_by_customer()} tickets were bought by #{customer1.name}"

p "#{film4.film_watched_by_customers()} customers are going to watch film #{film4.title}"

p "The most popular time for film3 is #{film3.popular_time()}"

binding.pry
nil
