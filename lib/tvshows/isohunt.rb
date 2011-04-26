require 'open-uri'
require 'nokogiri'
require_relative 'torrent'

module TVShows

  class ISOHunt

    def self.torrent(name, episode)
      new(name, episode).torrent
    end

    def initialize(name, episode)
      @name = name
      @episode = episode
    end

    def torrent
      puts "Searching for #{@name.inspect} #{@episode}"
      torrents.sort_by(&:priority).first
    end

    private

    def torrents
      rss_feed.css("item").reduce([]) do |torrents, item|
        next torrents unless url = item.css("enclosure").attr("url").value

        title = item.css("title").text
        next torrents unless title =~ /#{@name.gsub(/\s+/, '[+\.]')}[+\.]#{@episode}.*?HDTV.*?XviD.*?\s+\[(\d+)\/(\d+)\]/

        seeds = $1.to_i
        leeches = $2.to_i

        torrents << Torrent.new(@name, @episode, url, seeds, leeches)
      end
    end

    def rss_feed
      puts "Loading feed"
      Nokogiri::HTML(open(rss_url))
    end

    def rss_url
      "http://isohunt.com/js/rss/#{@name.gsub(/\s+/, '+')}+#{@episode}+HDTV+XviD?iht=3"
    end

  end

end
