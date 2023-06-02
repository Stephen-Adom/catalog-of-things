require_relative '../classes/game'

RSpec.describe Game do
  let(:genre) { double('Genre') }
  let(:author) { double('Author') }
  let(:label) { double('Label') }
  let(:publish_date) { Date.new(2010, 1, 1) }

  describe '#initialize' do
    it 'sets the genre, author, label, publish date, multiplayer, and last played at' do
      game = Game.new(genre, author, label, publish_date, multiplayer: true, last_played_at: '2020-01-01')

      expect(game.genre).to eq(genre)
      expect(game.author).to eq(author)
      expect(game.label).to eq(label)
      expect(game.publish_date).to eq(publish_date)
      expect(game.multiplayer).to eq(true)
      expect(game.last_played_at).to eq('2020-01-01')
    end
  end

  describe '#can_be_archived?' do
    context 'when the game can be archived' do
      it 'returns true' do
        game = Game.new(genre, author, label, publish_date, last_played_at: '2021-06-01')

        expect(game.can_be_archived?).to eq(true)
      end
    end

    context 'when the game cannot be archived' do
      it 'returns false' do
        game = Game.new(genre, author, label, publish_date, last_played_at: '2023-08-23')

        expect(game.can_be_archived?).to eq(false)
      end
    end
  end
end
