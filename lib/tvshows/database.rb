class Database

  def self.load(filename)
    new(filename).tap do |database|
      database.load
    end
  end

  def load
  end

  def save
  end

end
