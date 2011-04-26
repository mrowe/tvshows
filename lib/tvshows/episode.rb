module TVShows

  class Episode

    def self.deserialize(show, attributes)
      new(attributes[:season], attributes[:number])
    end

    def serialize
      { season: @season, number: @number }
    end

    def initialize(season, number)
      @season = season
      @number = number
    end

    def find_next
      yield(self.class.new(@season, @number.next)) || yield(self.class.new(@season.next, 1))
    end

    def to_s
      "S#{sprintf('%02d', @season)}E#{sprintf('%02d', @number)}"
    end

    NONE = new(0, 0)

  end

end
