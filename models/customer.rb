require_relative("../db/sql_runner.rb")

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save()
    sql = "INSERT INTO customers (name,funds) VALUES ($1,$2) RETURNING id"
    values = [@name, @funds]
    result = SqlRunner.run(sql,values).first
    @id = result['id'].to_i
  end

  def delete()
    sql = "DELETE FROM customers WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql,values)
  end

  def update()
    sql = "UPDATE customers SET (name,funds) = ($1,$2) WHERE id = $3"
    values = [@name,@funds,@id]
    SqlRunner.run(sql,values)
  end

  def films()
    sql = "SELECT films.* FROM films INNER JOIN tickets
    ON films.id = tickets.film_id WHERE customer_id = $1"
    values = [@id]
    films = SqlRunner.run(sql, values)
    return films.map{|film| Film.new(film)}
  end

  def decrease_customer_funds
    prices = films().map{|number| number.price.to_i}
    total_price = prices.sum
    @funds -= total_price
    update()
  end

  def tickets_bought_by_customer()
    sql = "SELECT tickets.* FROM tickets INNER JOIN customers
    ON customers.id = tickets.customer_id WHERE customer_id = $1"
    values = [@id]
    ticket_hash = SqlRunner.run(sql,values)
    return ticket_hash.count()
  end

  def self.all()
    sql = "SELECT * FROM customers"
    customers = SqlRunner.run(sql)
    return customers.map {|customer| Customer.new(customer)}
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

end
