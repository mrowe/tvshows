require 'nokogiri'
require 'open-uri'

class Show < Struct.new(:name, :episodes)

  def update(download_directory)
    puts "Updating #{name}..."
    new_episodes.sort_by(&:sequence).each do |episode|
      episode.download_to(File.join(download_directory, name))
      add_episode(episode)
    end
  end

  def add_episode(episode)
    episodes << episode
  end

  def most_recent_episode
    episodes.last || Episode::NEVER
  end

  def new_episodes
    recent_episodes
      .reject { |episode| episode <= most_recent_episode }
      .group_by(&:sequence)
      .map { |sequence, episodes| episodes.sort_by(&:priority).first }
  end

  def recent_episodes
    rss_feed.css("item").reduce([]) do |episodes, item|
      next episodes unless url = item.css("enclosure").attr("url").value

      title = item.css("title").text
      next episodes unless title =~ /#{name}\.S(\d+)E(\d+)\.HDTV\.XviD-LOL(?:.*?)\s+\[(\d+)\/(\d+)\]/

      season = $1.to_i
      number = $2.to_i
      seeds = $3.to_i
      leeches = $4.to_i

      episodes << Episode.new(season, number, seeds, leeches, url)
    end
  end

  def rss_feed
    Nokogiri::HTML(open("http://isohunt.com/js/rss/#{name}.HDTV.XviD-LOL.avi?iht="))
  end

end
