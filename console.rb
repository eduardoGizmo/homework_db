require_relative('model/screening')
require_relative('model/ticket')
require_relative('model/film')
require_relative('model/customer')



require('pry-byebug')


Film.delete_all()
Customer.delete_all()
Ticket.delete_all()
Screening.delete_all()


#  CUSTOMERS

customer1 = Customer.new('name' => 'Fran', 'funds' => 30)
customer1.save()
customer2 = Customer.new('name' => 'Ed', 'funds' => 20)
customer2.save()
customer3 = Customer.new('name' => 'Lisa', 'funds' => 40)
customer3.save()


# FILMS

film1 = Film.new('title' => 'A Great Film', 'price' => 8)
film1.save()
film2 = Film.new('title' => 'The Good Movie', 'price' => 7)
film2.save()
film3 = Film.new('title' => 'Screening Till Late', 'price' => 9)
film3.save()


# TICKETS

ticket1 = Ticket.new('customer_id' => customer1.id, 'film_id' => film1.id)
ticket1.save()
ticket2 = Ticket.new('customer_id' => customer2.id, 'film_id' => film1.id)
ticket2.save()
ticket3 = Ticket.new('customer_id' => customer2.id, 'film_id' => film2.id)
ticket3.save()
ticket4 = Ticket.new('customer_id' => customer3.id, 'film_id' => film1.id)
ticket4.save()
ticket5 = Ticket.new('customer_id' => customer3.id, 'film_id' => film2.id)
ticket5.save()
ticket6 = Ticket.new('customer_id' => customer3.id, 'film_id' => film3.id)
ticket6.save()
ticket7 = Ticket.new('customer_id' => customer1.id, 'film_id' => film2.id)
ticket7.save()


# SCREENINGS

screening1 = Screening.new('screening_time' => '17:00', 'film_id' => film1.id)
screening1.save()

screening2 = Screening.new('screening_time' => '19:00', 'film_id' => film2.id)
screening2.save()

screening3 = Screening.new('screening_time' => '21:00', 'film_id' => film3.id)
screening3.save()

screening4 = Screening.new('screening_time' => '18:30', 'film_id' => film2.id)
screening4.save()

binding.pry
nil
