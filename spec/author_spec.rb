require_relative '../classes/author'
require_relative '../classes/item'

RSpec.describe Author do
  let(:author) { Author.new('John', 'Doe') }

  describe '#add_item' do
    it 'adds an item to the author' do
      item = Item.new('Genre', author, 'Label', Date.today)
      author.add_item(item)
      expect(author.items).to include(item)
    end

    it 'does not add the same item twice' do
      item = Item.new('Genre', author, 'Label', Date.today)
      author.add_item(item)
      author.add_item(item)
      expect(author.items.size).to eq(1)
    end
  end
end
