require_relative 'tvshows/database'

TVShows::Database.open do |database|
  database.each_show do |show|
    show.download_to("/Users/haruki_zaemon/Downloads")
  end
end
