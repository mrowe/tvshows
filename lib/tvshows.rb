require_relative 'tvshows/episode'
require_relative 'tvshows/show'
require_relative 'tvshows/database'

Database.open do |shows|
  shows.each do |show|
    show.update("/Users/haruki_zaemon/Downloads")
  end
end

# shows = [
#   Show.new("Boardwalk.Empire", [Episode.new(1, 5)]),
#   Show.new("Castle.2009", [Episode.new(3, 21)]),
#   Show.new("House", [Episode.new(7, 19)]),
#   Show.new("Justified", [Episode.new(2, 11)]),
#   Show.new("Misfits", [Episode.new(2, 7)]),
#   Show.new("Modern.Family", [Episode.new(2, 20)]),
#   Show.new("NCIS", [Episode.new(8, 21)]),
#   Show.new("Rules.of.Engagement", [Episode.new(8, 21)]),
#   Show.new("Sherlock", [Episode.new(1, 3)]),
#   Show.new("Spooks", [Episode.new(9, 8)]),
#   Show.new("The.Big.Bang.Theory", [Episode.new(4, 20)]),
#   Show.new("The.Good.Wife", [Episode.new(2, 20)]),
#   Show.new("Treme", [Episode.new(1, 10)]),
#   Show.new("United.States.of.Tara", [Episode.new(3, 4)]),
# ]
