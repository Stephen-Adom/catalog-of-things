require 'date'

class Item
  attr_reader :id, :archived
  attr_accessor :genre, :author, :label, :publish_date

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
    difference_between_years > 10
  end

  def move_to_archive
    @archived = true if can_be_archived?
  end

  private

  def difference_between_years
<<<<<<< HEAD
    Date.today.year - @publish_date.year
=======
    current_year = Date.today.year
    current_year - @publish_date.year
>>>>>>> dev
  end
end
