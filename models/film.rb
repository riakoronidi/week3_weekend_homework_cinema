require_relative("../db/sql_runner.rb")

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i
  end

  def save()
    sql = "INSERT INTO films (title,price) VALUES ($1,$2) RETURNING id"
    values = [@title, @price]
    result = SqlRunner.run(sql,values).first
    @id = result['id'].to_i
  end

  def delete()
    sql = "DELETE FROM films WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql,values)
  end

  def update()
    sql = "UPDATE films SET (title,price) = ($1,$2) WHERE id = $3"
    values = [@title,@price,@id]
    SqlRunner.run(sql,values)
  end

  def customers()
    sql = "SELECT customers.* FROM customers INNER JOIN tickets
    ON customers.id = tickets.customer_id WHERE film_id = $1"
    values = [@id]
    customers = SqlRunner.run(sql, values)
    return customers.map{|customer| Customer.new(customer)}
  end

  def film_watched_by_customers()
    sql = "SELECT films.* FROM films INNER JOIN tickets
    ON films.id = tickets.film_id WHERE film_id = $1"
    values = [@id]
    film_hash = SqlRunner.run(sql,values)
    return film_hash.count()
  end

  def self.all()
    sql = "SELECT * FROM films"
    films = SqlRunner.run(sql)
    return films.map {|film| Film.new(film)}
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

end
