require_relative '../classes/item'
require_relative '../classes/label'
require 'date'

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

describe 'Item' do
  let(:genre) { Genre.new('Fiction') }
  let(:author) { Author.new('J.K.', 'Rowling') }
  let(:label) { Label.new('New York Times') }
  let(:item) do
    Item.new(genre, author, label, Date.new(1997, 11, 11))
  end

  context '#initialize' do
    it 'should create an instance of Item' do
      expect(item).to be_instance_of(Item)
    end
  end

  context '#generate_id' do
    it 'should generate a unique id' do
      expect(item.id).to be_instance_of(Integer)
    end
  end

  context '#can_be_archived?' do
    it 'should return true' do
      expect(item.can_be_archived?).to be_truthy
    end
  end

  context '#move_to_archive' do
    it 'should move the item to the archive' do
      item.move_to_archive
      expect(item.archived).to be_truthy
    end
  end

  context '#difference_between_years' do
    it 'should return the difference between years' do
      result = item.send(:difference_between_years)
      expect(result).to be_instance_of(Integer)
    end
  end
end
