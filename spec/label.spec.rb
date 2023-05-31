require_relative '../classes/book'
require_relative '../classes/label'
require 'json'

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

describe 'Label' do
  let(:genre) { Genre.new('Fiction') }
  let(:author) { Author.new('J.K.', 'Rowling') }
  let(:label) { Label.new('test') }
  let(:book) do
    Book.new(genre, author, label, Date.new(1997, 11, 11),
             'Bloomsbury')
  end

  context '#title' do
    it 'should have a title' do
      expect(label.title).to eq 'test'
    end
  end

  context '#add_item' do
    it 'adds an item to the label' do
      label.add_item(book)
      expect(label.items.length).to eq 1
    end
  end

  context '#save_label_to_json' do
    it 'saves the label to a json file' do
      label.save_label_to_json([label])
      expect(File.exist?('data/label.json')).to be true
    end
  end

  context '#update_id' do
    it 'updates the id of the label' do
      label.update_id(1)
      expect(label.id).to eq 1
    end
  end
end
