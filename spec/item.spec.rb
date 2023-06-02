require_relative '../classes/item'
require_relative '../classes/label'
require_relative '../classes/genre'
require_relative '../classes/author'
require 'date'

describe 'Item' do
  let(:genre) { Genre.new('Fiction') }
  let(:author) { Author.new('J.K.', 'Rowling') }
  let(:label) { Label.new('New York Times') }
  let(:item) do
    Item.new(genre, author, label, '1997-11-11')
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
end
