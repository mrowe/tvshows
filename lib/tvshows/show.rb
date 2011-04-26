require_relative 'episode'
require_relative 'isohunt'

module TVShows

  class Show

    def self.deserialize(attributes)
      new(attributes[:name], Episode.deserialize(attributes[:last_downloaded_episode]))
    end

    def serialize
      { name: @name, last_downloaded_episode: @last_downloaded_episode.serialize }
    end

    def initialize(name, last_downloaded_episode = Episode::NONE)
      @name = name
      @last_downloaded_episode = last_downloaded_episode
    end

    def download_to(directory)
      while torrent = @last_downloaded_episode.find_next { |episode| ISOHunt.torrent(@name, episode) }
        torrent.download_to(directory)
        @last_downloaded_episode = torrent.episode
      end
    end

  end

end
