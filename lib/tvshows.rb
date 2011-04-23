require_relative 'tvshows/episode'
require_relative 'tvshows/show'

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
