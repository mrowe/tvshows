require_relative 'tvshows/database'

Database.open do |database|
  database.each do |show|
    show.update("/Users/haruki_zaemon/Downloads")
  end
end
