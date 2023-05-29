require 'date'

class Item
  att_reader :id, :archived

  att_accessor :genre, :author, :source, :label, :publish_date

  def initialize(genre, author, source, label, publish_date)
    @id = generate_id
    @archived = false
    @genre = genre
    @author = author
    @source = source
    @label = label
    @publish_date = publish_date
  end

  def generate_id
    (rand * 1000).floor
  end

  def can_be_archived?
    difference_between_years > 10
  end

  def move_to_archive
    @archived = true if can_be_archived?
  end

  private

  def difference_between_years
    current_year = Date.today.year
    @publish_date.year
    current_year - published_year
  end
end
