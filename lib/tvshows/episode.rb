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
