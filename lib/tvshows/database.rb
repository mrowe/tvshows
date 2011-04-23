require 'json'
require_relative 'show'

class Database

  def self.open(filename = File.expand_path("../../../db/tvshows.json", __FILE__))
    database = new(filename)
    database.load
    yield(database)
    database.save
  end

  def initialize(filename)
    @filename = filename
  end

  def load
    @shows = (JSON.parse(File.read(@filename), :symbolize_names => true) || []).map do |attributes|
      Show.deserialize(attributes)
    end
  end

  def save
    File.open(@filename, "w") do |file|
      file.write(JSON.generate(@shows.map(&:serialize)))
    end
  end

  def add(show)
    @shows << show
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
