require_relative 'tvshows/database'

TVShows::Database.open do |database|
  database.each do |show|
    show.update("/Users/haruki_zaemon/Downloads")
  end
end
