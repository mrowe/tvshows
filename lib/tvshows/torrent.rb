require 'open-uri'
require_relative 'isohunt'

module TVShows

  class Torrent

    def self.deserialize(show, attributes)
      new(attributes[:name], attributes[:season], attributes[:episode], attributes[:url])
    end

    def serialize
      {name: @name, season: @season, episode: @episode, url: @url}
    end

    def initialize(name, season, episode, url = nil, seeds = 0, leeches = 0)
      @name = name
      @season = season
      @episode = episode
      @url = url
      @seeds = seeds
      @leeches = leeches
    end

    def filename
      "#{@name}.S#{sprintf('%02d', @season)}E#{sprintf('%02d', @episode)}.torrent"
    end

    def priority
      [-@seeds, @leeches]
    end

    def next
      ISOHunt.find(@name, @season, @episode.next) || ISOHunt.find(@name, @season.next, 1)
    end

    def download_to(directory)
      File.open(File.join(directory, filename), "w") do |file|
        file.write(open(@url))
      end
    end

  end

end
