require_relative('../db/sql_runner')


class Screening

  attr_reader :id
  attr_accessor :screening_time, :film_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @screening_time = options['screening_time']
    @film_id = options['film_id'].to_i
  end

  def save()
    sql = "INSERT INTO screenings (screening_time, film_id) VALUES ($1, $2) RETURNING id;"
    values = [@screening_time, @film_id]
    screening = SqlRunner.run(sql, values)[0]
    @id = screening['id'].to_i
  end

  def update()
    sql = "UPDATE screenings SET (screening_time, film_id, id) VALUES ($1, $2) WHERE id = $3;"
    values = [@screening_time, @film_id, @id]
    SqlRunner.run(sql, values)
  end

  def self.map_items(data)
    result = data.map{|screening| Screening.new(screening)}
    return result
  end

  def self.all()
    sql = "SELECT * FROM screenings;"
    data = SqlRunner.run(sql)
    return data
  end

  def self.delete_all()
    sql = "DELETE FROM screenings;"
    SqlRunner.run(sql)
  end


end
