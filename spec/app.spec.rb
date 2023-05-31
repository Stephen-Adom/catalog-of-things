require_relative '../app'
require_relative '../classes/label'

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
      expect(app.all_books.length).to eql 0
    end
  end

  context '#labels array' do
    it 'should list all labels' do
      expect(app.all_labels.length).to eql 0
    end
  end

  context '#genres array' do
    it 'should list all genres' do
      expect(app.all_genres.length).to eql 0
    end
  end

  context '#authors array' do
    it 'should list all authors' do
      expect(app.all_authors.length).to eql 0
    end
  end

  context '#create_book_object' do
    it 'creates a book object' do
      book_obj = {
        label: 'test',
        author: ' J.K. Rowling',
        genre: 'Fiction',
        publisher: 'Bloomsbury',
        published_date: '1997-11-11',
        cover_state: 'good'
      }
      app.create_book_object(book_obj)
      expect(app.all_books.length).to eql 1
    end
  end

  context '#create_book_label' do
    it 'creates a book label' do
      label_obj = {
        title: 'test',
        color: 'unknown'
      }

      app.create_book_label(label_obj)
      expect(app.all_labels.length).to eql 1
    end
  end

  context '#create_label_obj' do
    it 'should create label object' do
      expect(app.create_label_obj('test')).to be_instance_of(Label)
    end
  end

  context '#create_book_author' do
    it 'should create author object' do
      expect(app.create_author_obj('J.K. Rowling')).to be_instance_of(Author)
    end
  end

  context '#create_author_full_name' do
    it 'should create author full name' do
      expect(app.create_author_full_name('J.K.', 'Rowling')).to eql 'J.K. Rowling'
    end
  end

  context '#create book genre' do
    it 'should create genre' do
      expect(app.create_book_genre('Fiction')).to be_instance_of(Genre)
    end
  end
end
