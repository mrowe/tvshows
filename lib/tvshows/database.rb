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
      @shows = parsed.map do |attributes|
        Show.deserialize(attributes)
      end
    end

    def save
      File.open(@filename, "w") do |file|
        file.write(formatted)
      end
    end

    def each_show(&block)
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
