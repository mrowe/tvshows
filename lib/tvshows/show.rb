require_relative 'torrent'

module TVShows

  class Show

    def self.deserialize(attributes)
      new(attributes[:name], attributes[:last_downloaded_torrent])
    end

    def serialize
      { name: @name, last_downloaded_torrent: @last_downloaded_torrent.serialize }
    end

    def initialize(name, last_downloaded_torrent = Torrent.new(name, 0, 0))
      @name = name
      @last_downloaded_torrent = last_downloaded_torrent
    end

    def download_to(directory)
      if next_torrent = @last_downloaded_torrent.next
        next_torrent.download_to(directory)
        @last_downloaded_torrent = next_torrent
      end
    end

  end

end
