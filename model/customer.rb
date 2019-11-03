require_relative('../db/sql_runner')


class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end

# Save entry to the database customers

  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ($1, $2) RETURNING id"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values)[0]
    @id = customer['id'].to_i
  end

# Update row from the database customers

  def update()
    sql = "UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end


#  Delete row from the database customers

  def delete()
    sql = "DELETE FROM customers WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

# Show the films a particular customer has booked

  def films()
    sql = "SELECT films.* FROM films INNER JOIN tickets ON films.id = tickets.film_id WHERE customer_id = $1"
    values = [@id]
    film_data = SqlRunner.run(sql, values)
    return Film.map_items(film_data)
  end

#  Buying tickets - Decrease the funds of the customer

    def buy_tickets()
      tickets = self.films()
      ticket_prices = tickets.map{|ticket| ticket.price}
      # total_tickets = ticket_prices.sum() # only works on rails!!!
      total_tickets = ticket_prices.inject(0) {|sum, i|  sum + i }
      return @funds - total_tickets
    end

# Check how many tickets were bought by a customer

    def num_of_tickets
      tickets = self.films
      return tickets.size
    end

# Create array from customers database

  def self.map_items(data)
    result = data.map{|customer| Customer.new(customer)}
    return result
  end

# Show all the results from customers database in an array

  def self.all()
    sql = "SELECT * FROM customers"
    data = SqlRunner.run(sql)
    return data.map{|customer| Customer.new(customer)}
  end

#  delete all

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

end
