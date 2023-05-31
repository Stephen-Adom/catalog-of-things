require_relative '../classes/author'


RSpec.describe Author do
  let(:author) { Author.new('John', 'Doe') }

  describe '#add_item' do
    it 'adds an item to the author' do
      item = double('Item')
      expect(item).to receive(:author=).with(author)
      author.add_item(item)
      expect(author.items).to include(item)
    end

    it 'does not add the same item twice' do
      item = double('Item')
      expect(item).to receive(:author=).with(author).once
      author.add_item(item)
      author.add_item(item)
      expect(author.items.size).to eq(1)
    end
  end
end
