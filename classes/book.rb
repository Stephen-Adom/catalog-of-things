require_relative 'item'
require 'date'

class Book < Item
  attr_accessor :publisher, :cover_state

  def initialize(genre, author, label, publish_date, publisher)
    super(genre, author, label, publish_date)
    @publisher = publisher
    @cover_state = 'good'
  end

  def can_be_archived?
    super || @cover_state == 'bad'
  end

  def update_id(id)
    @id = id
  end

  def update_cover_state(state)
    @cover_state = state
  end

  def save_books_to_json(all_books)
    File.write('data/books.json', JSON.dump({
                                              data: all_books.map do |book|
                                                {
                                                  id: book.id,
                                                  genre: book.genre.id,
                                                  author: book.author.id,
                                                  label: book.label.id,
                                                  publish_date: book.publish_date,
                                                  publisher: book.publisher,
                                                  cover_state: book.cover_state
                                                }
                                              end
                                            }))
  end
end
