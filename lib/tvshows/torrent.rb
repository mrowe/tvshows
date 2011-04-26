require 'open-uri'

module TVShows

  class Torrent

    attr_reader :episode

    def initialize(name, episode, url, seeds, leeches)
      @name = name
      @episode = episode
      @url = url
      @seeds = seeds
      @leeches = leeches
    end

    def filename
      "#{@name}.#{@episode}.torrent"
    end

    def priority
      [-@seeds, @leeches]
    end

    def download_to(directory)
      puts "Downloading #{@url} to #{File.join(directory, filename)}"
      File.open(File.join(directory, filename), "w") do |file|
        file.write(open(@url))
      end
    end

  end

end
