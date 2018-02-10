require_relative("../db/sql_runner.rb")

class Screening

  attr_reader :id
  attr_accessor :screening, :film_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @screening = options['screening']
    @film_id = options['film_id'].to_i
  end

  def save()
    sql = "INSERT INTO screenings (screening,film_id) VALUES ($1,$2) RETURNING id"
    values = [@screening,@film_id]
    result = SqlRunner.run(sql,values).first
    @id = result['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM screenings"
    screenings = SqlRunner.run(sql)
    return screenings.map {|screening| Screening.new(screening)}
  end

  def self.delete_all()
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)
  end
end
