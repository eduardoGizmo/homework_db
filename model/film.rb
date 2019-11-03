require_relative('../db/sql_runner')


 class Film

   attr_reader :id
   attr_accessor :title, :price

   def initialize(options)
     @id = options['id'].to_i if options['id']
     @title = options['title']
     @price = options['price'].to_i
   end


   def save()
     sql = "INSERT INTO films (title, price) VALUES ($1, $2) RETURNING id"
     values = [@title, @price]
     film = SqlRunner.run(sql, values)[0]
     @id = film['id'].to_i
  end


  def update()
    sql = "UPDATE films SET(title, price) = ($1, $2) WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end


  def delete()
    sql = "DELETE FROM films WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

# Show the customers that have booked particular film
  def customers()
    sql = "SELECT customers.* FROM customers INNER JOIN tickets ON customers.id = tickets.customer_id WHERE film_id = $1"
    values = [@id]
    customer_data = SqlRunner.run(sql, values)
    return Customer.map_items(customer_data)
  end

# Show how many customers have booked particular film

  def num_of_customers
    total_customers = self.customers
    return total_customers.size
  end

  def self.map_items(data)
    result = data.map{|film| Film.new(film)}
    return result
  end

  # Find screening time by film

  def film_time()
    sql ="SELECT screenings.* FROM screenings WHERE film_id = $1;"
    values = [@id]
    screening_times = SqlRunner.run(sql, values)
    time_object = Screening.map_items(screening_times)
    return time_object.map {|time| time.screening_time}
  end

  # Return all the films as objects

  def self.all()
    sql = "SELECT * FROM films"
    data = SqlRunner.run(sql)
    return Film.map_items(data)
  end


  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end


 end
