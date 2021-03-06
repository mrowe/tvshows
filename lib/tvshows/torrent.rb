require 'open-uri'

module TVShows

  class Torrent

    attr_reader :episode

    def initialize(name, episode, uri, seeds, leeches)
      @name = name
      @episode = episode
      @uri = uri
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
      puts "Downloading #{@uri} to #{File.join(directory, filename)}"
      File.open(File.join(directory, filename), "w") do |file|
        file.write(@uri.read)
      end
    end

  end

end
