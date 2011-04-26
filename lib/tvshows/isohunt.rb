require 'open-uri'
require 'nokogiri'
require_relative 'torrent'

module TVShows

  class ISOHunt

    def self.find(name, season, episode)
      new(name, season, episode).find
    end

    def initialize(name, season, episode)
      @name = name
      @season = season
      @episode = episode
    end

    def find
      torrents.sort_by(&:priority).first
    end

    def torrents
      rss_feed.css("item").reduce([]) do |torrents, item|
        next torrents unless url = item.css("enclosure").attr("url").value

        title = item.css("title").text
        next torrents unless title =~ /#{@name.gsub(/\s+/, '[+\.]')}[+\.]#{season_episode_label}.*?HDTV.*?XviD.*?\s+\[(\d+)\/(\d+)\]/

        seeds = $1.to_i
        leeches = $2.to_i

        torrents << Torrent.new(@name, @season, @episode, url, seeds, leeches)
      end
    end

    def rss_feed
      Nokogiri::HTML(open(rss_url))
    end

    def rss_url
      "http://isohunt.com/js/rss/#{@name.gsub(/\s+/, '+')}+#{season_episode_label}+HDTV+XviD?iht=3"
    end

    def season_episode_label
      "S#{sprintf('%02d', @season)}E#{sprintf('%02d', @episode)}"
    end

  end

end
