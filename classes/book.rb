require_relative 'item'
require 'date'

class Book < Item
  attr_accessor :publisher, :cover_state

  def initialize(genre, author, source, label, publish_date, publisher, cover_state)
    super(genre, author, source, label, publish_date)
    @publisher = publisher
    @cover_state = cover_state
  end

  def can_be_archived?
    super || @cover_state == 'bad'
  end
end

book = Book.new('genre', 'alaska', 'medium', 'new book', Date.parse('1990-12-12'), 'hunn', 'good')
puts book.can_be_archived?
