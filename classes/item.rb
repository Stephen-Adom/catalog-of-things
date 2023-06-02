require 'date'

class Item
  attr_reader :id, :archived, :genre, :author, :label
  attr_accessor :publish_date

  def initialize(genre, author, label, publish_date)
    @id = generate_id
    @archived = false
    @genre = genre
    @author = author
    @label = label
    @publish_date = publish_date
  end

  def generate_id
    (rand * 1000).floor
  end

  def can_be_archived?
    today = Date.today
    ten_years_ago = Date.new(today.year - 10, today.month, today.day)

    Date.parse(@publish_date.to_s) < ten_years_ago
  end

  def move_to_archive
    @archived = true if can_be_archived?
  end

  def genre=(genre)
    @genre = genre
    genre.items << self unless genre.items.include?(self)
  end

  def author=(author)
    @author = author
    author.items << self unless author.items.include?(self)
  end

  def label=(label)
    @label = label
    label.items << self unless label.items.include?(self)
  end
end
