class Episode < Struct.new(:season, :number, :seeds, :leeches, :url)

  include Comparable

  def <=>(other)
    if season > other.season
      1
    elsif season < other.season
      -1
    else
      number <=> other.number
    end
  end

  def sequence
    [season, number]
  end

  def priority
    [-seeds, leeches]
  end

  def download_to(base_filename)
    filename = "#{base_filename}.S#{season}E#{number}.torrent"
    puts "  Downloading #{url} to #{filename}"
    File.open(filename, "w") do |file|
      file.write(open(url))
    end
  end

  NEVER = new(0, 0, 0, 0, nil)

end
