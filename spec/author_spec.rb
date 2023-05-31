require_relative '../classes/author'

RSpec.describe Author do
  let(:author) { Author.new('John', 'Doe') }
  let(:game) { Game.new('Action', author, 'Game Label', Date.new(2010, 1, 1), true, Date.new(2021, 1, 1)) }

  describe '#add_item' do
    context 'when adding a new item' do
      it 'adds the item to the author\'s items collection' do
        expect do
          author.add_item(game)
        end.to change { author.items.length }.by(1)
      end

      it 'sets the author of the item to the current author' do
        author.add_item(game)
        expect(game.author).to eq(author)
      end
    end

    context 'when adding an existing item' do
      it 'does not add the item to the author\'s items collection' do
        author.add_item(game)
        expect do
          author.add_item(game)
        end.not_to(change { author.items.length })
      end
    end
  end
end
