class Database

  def self.open(filename = File.expand_path("../../../db/tvshows.json", __FILE__))
    database = new(filename)
    database.load
    yield(database)
    database.save
  end

  def initialize(filename)
    @filename = filename
    @shows = []
  end

  def load
    # TODO
  end

  def save
    File.open(@filename, "w") do |file|
      # TODO
    end
  end

  def add(name)
    @shows << Show.new(name, [])
  end

  def delete(name)
    @shows.delete(get(name))
  end

  def get(name)
    @shows.find { |show| show.name == name }
  end

  def each(&block)
    @shows.each(&block)
  end

end
