require_relative '../classes/book'
require_relative '../classes/label'
require 'date'
require 'json'
require 'pry'

class Genre
  attr_reader :id, :items
  attr_accessor :name

  def initialize(name)
    @id = generate_id
    @name = name
    @items = []
  end

  def add_item(item)
    @items << item unless @items.include?(item)
    item.genre = self
  end

  def update_id(id)
    @id = id
  end

  private

  def generate_id
    (rand * 1000).floor
  end
end

class Author
  attr_reader :id, :items
  attr_accessor :first_name, :last_name

  def initialize(first_name, last_name)
    @id = generate_id
    @first_name = first_name
    @last_name = last_name
    @items = []
  end

  def add_item(item)
    @items << item unless @items.include?(item)
    item.author = self
  end

  def update_id(id)
    @id = id
  end

  private

  def generate_id
    (rand * 1000).floor
  end
end

describe 'Book' do
  let(:genre) { Genre.new('Fiction') }
  let(:author) { Author.new('J.K.', 'Rowling') }
  let(:label) { Label.new('Harry Potter') }
  let(:book) do
    Book.new(genre, author, label, Date.new(1997, 11, 11),
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

  context '#save_books_to_json' do
    it 'should save the books to the json file' do
      book.save_books_to_json([book])
      expect(File.exist?('data/books.json')).to be_truthy
    end
  end
end
