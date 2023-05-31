require 'rspec'
require_relative '../classes/music'
require_relative '../classes/genre'
require_relative '../classes/label'

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

describe Genre do
  let(:genre) { Genre.new('Pop') }
  let(:author) { Author.new('J.K.', 'Rowling') }
  let(:label) { Label.new('test') }
  let(:album) { MusicAlbum.new(genre, author, label, true, '2022-05-05') }

  describe '#initialize' do
    it 'should create a new Genre with the given name' do
      genre = Genre.new('Pop')
      expect(genre.name).to eq('Pop')
      expect(genre.items).to be_empty
    end
  end

  describe '#add_item' do
    it 'should add the given item to the Genre' do
      genre.add_item(album)

      expect(genre.items).to include(album)
      expect(album.genre).to eq(genre)
    end
  end
end
