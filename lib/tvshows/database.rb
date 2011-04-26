require 'json'
require_relative 'show'

module TVShows

  class Database

    def self.open(filename = File.expand_path("../../../db/database.json", __FILE__))
      database = new(filename)
      database.load
      yield(database)
      database.save
    end

    def initialize(filename)
      @filename = filename
    end

    def load
      puts "Loading database"
      @shows = parsed.map { |attributes| Show.deserialize(attributes) }
    end

    def save
      puts "Saving database"
      File.open(@filename, "w") { |file| file.write(formatted) }
    end

    def clear
      @shows = []
    end

    def add(show)
      @shows << show
    end

    def each(&block)
      @shows.each(&block)
    end

    private

    def formatted
      JSON.pretty_generate(@shows.map(&:serialize))
    end

    def parsed
      JSON.parse(read, :symbolize_names => true)
    end

    def read
      File.exists?(@filename) ? File.read(@filename) : "[]"
    end

  end

end
