require_relative 'tvshows/database'

downloads = ARGV[0] || File.join(ENV["HOME"], "Downloads")
raise "Unable to find a download directory" unless File.exists?(downloads)

TVShows::Database.open do |shows|
  shows.each { |show| show.download_to(downloads) }
end
