require_relative '../classes/book'
require_relative '../classes/label'
require_relative '../classes/genre'
require_relative '../classes/author'
require 'date'
require 'json'

describe 'Book' do
  let(:genre) { Genre.new('Fiction') }
  let(:author) { Author.new('J.K.', 'Rowling') }
  let(:label) { Label.new('Harry Potter') }
  let(:book) do
    Book.new(genre, author, label, '1997-11-11',
             'Bloomsbury')
  end

  context '#can_be_archived?' do
    it 'should return true when the book is more than 10 years old' do
      expect(book.can_be_archived?).to be_truthy
    end
  end

  context '#move_to_archive' do
    it 'should move the book to the archive' do
      expect(book.move_to_archive).to be_truthy
    end
  end

  context '#update_cover_state' do
    it 'should update the cover state' do
      cover_state = 'good'
      book.update_cover_state(cover_state)
      expect(book.cover_state).to eql cover_state
    end
  end
end
