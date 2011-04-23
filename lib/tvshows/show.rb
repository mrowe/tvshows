require 'nokogiri'
require 'open-uri'

class Show < Struct.new(:name, :torrents)

  def update(download_directory)
    puts "Updating #{name}..."
    new_torrents.sort_by(&:sequence).each do |torrent|
      torrent.download_to("#{download_directory}/#{name}")
      torrents << torrent
    end
  end

  def most_recent_torrent
    torrents.last
  end

  def new_torrents
    all_torrents
      .reject { |torrent| torrent <= most_recent_torrent }
      .group_by(&:sequence)
      .map { |sequence, torrents| torrents.sort_by(&:priority).first }
  end

  def all_torrents
    rss.css("item").reduce([]) do |torrents, item|
      next torrents unless url = item.css("enclosure").attr("url").value

      title = item.css("title").text
      next torrents unless title =~ /#{name}\.S(\d+)E(\d+)\.HDTV\.XviD-LOL(?:.*?)\s+\[(\d+)\/(\d+)\]/

      season = $1.to_i
      episode = $2.to_i
      seeds = $3.to_i
      leeches = $4.to_i

      torrents << Torrent.new(season, episode, seeds, leeches, url)
    end
  end

  def rss
    Nokogiri::HTML(open("http://isohunt.com/js/rss/#{name}.HDTV.XviD-LOL.avi?iht="))
  end

end
