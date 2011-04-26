require_relative 'tvshows/database'

TVShows::Database.open do |shows|

  shows.clear

  shows.add(TVShows::Show.new("Boardwalk Empire", TVShows::Episode.new(1, 5)))
  shows.add(TVShows::Show.new("Castle 2009", TVShows::Episode.new(3, 20)))
  shows.add(TVShows::Show.new("House", TVShows::Episode.new(7, 18)))
  shows.add(TVShows::Show.new("Justified", TVShows::Episode.new(2, 10)))
  shows.add(TVShows::Show.new("Misfits", TVShows::Episode.new(2, 7)))
  shows.add(TVShows::Show.new("Modern Family", TVShows::Episode.new(2, 19)))
  shows.add(TVShows::Show.new("NCIS", TVShows::Episode.new(8, 20)))
  shows.add(TVShows::Show.new("Rules of Engagement", TVShows::Episode.new(8, 20)))
  shows.add(TVShows::Show.new("Sherlock", TVShows::Episode.new(1, 2)))
  shows.add(TVShows::Show.new("Spooks", TVShows::Episode.new(9, 7)))
  shows.add(TVShows::Show.new("The Big Bang Theory", TVShows::Episode.new(4, 19)))
  shows.add(TVShows::Show.new("The Good Wife", TVShows::Episode.new(2, 19)))
  shows.add(TVShows::Show.new("Treme", TVShows::Episode.new(1, 9)))
  shows.add(TVShows::Show.new("United States of Tara", TVShows::Episode.new(3, 3)))


  shows.each { |show| show.download_to("/Users/haruki_zaemon/Downloads") }
end
