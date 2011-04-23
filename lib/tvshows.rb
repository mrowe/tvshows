require 'nokogiri'
require 'open-uri'

class Show < Struct.new(:name, :last_torrent)

  def update(download_directory)
    puts "Updating #{name}..."
    new_torrents.sort_by(&:sequence).each do |torrent|
      torrent.download_to("#{download_directory}/#{name}")
      self.last_torrent = torrent
    end
  end

  def new_torrents
    all_torrents
      .reject { |torrent| torrent <= last_torrent }
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

class Torrent < Struct.new(:season, :episode, :seeds, :leeches, :url)

  include Comparable

  def <=>(other)
    if season > other.season
      1
    elsif season < other.season
      -1
    else
      episode <=> other.episode
    end
  end

  def sequence
    [season, episode]
  end

  def priority
    [-seeds, leeches]
  end

  def download_to(base_filename)
    filename = "#{base_filename}.S#{season}E#{episode}.torrent"
    puts "  Downloading #{url} to #{filename}"
    File.open("#{filename}", "w") do |file|
      file.write(open(url))
    end
  end

end

shows = [
  Show.new("Boardwalk.Empire", Torrent.new(1, 5)),
  Show.new("Castle.2009", Torrent.new(3, 21)),
  Show.new("House", Torrent.new(7, 19)),
  Show.new("Justified", Torrent.new(2, 11)),
  Show.new("Misfits", Torrent.new(2, 7)),
  Show.new("Modern.Family", Torrent.new(2, 20)),
  Show.new("NCIS", Torrent.new(8, 21)),
  Show.new("Rules.of.Engagement", Torrent.new(8, 21)),
  Show.new("Sherlock", Torrent.new(1, 3)),
  Show.new("Spooks", Torrent.new(9, 8)),
  Show.new("The.Big.Bang.Theory", Torrent.new(4, 20)),
  Show.new("The.Good.Wife", Torrent.new(2, 20)),
  Show.new("Treme", Torrent.new(1, 10)),
  Show.new("United.States.of.Tara", Torrent.new(3, 4)),
]

shows.each do |show|
  show.update("/Users/haruki_zaemon/Downloads")
end
