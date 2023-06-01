require_relative '../app'
require_relative '../classes/label'
require_relative '../classes/files_handler'

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

  def save_genre_to_json(_all_genres)
    true
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

  def save_author_to_json(_all_authors)
    true
  end

  private

  def generate_id
    (rand * 1000).floor
  end
end

describe 'App' do
  let(:app) { App.new }

  context '#books array' do
    it 'should list all books' do
      books = Storage.read_file_content('books.json')
      expect(app.all_books.length).to eql books.length
    end
  end

  context '#labels array' do
    it 'should list all labels' do
      labels = Storage.read_file_content('label.json')
      expect(app.all_labels.length).to eql labels.length
    end
  end

  context '#genres array' do
    it 'should list all genres' do
      genres = Storage.read_file_content('genres.json')
      expect(app.all_genres.length).to eql genres.length
    end
  end

  context '#authors array' do
    it 'should list all authors' do
      authors = Storage.read_file_content('authors.json')
      expect(app.all_authors.length).to eql authors.length
    end
  end

  context '#create_author_full_name' do
    it 'should create author full name' do
      expect(app.create_author_full_name('J.K.', 'Rowling')).to eql 'J.K. Rowling'
    end
  end
end
