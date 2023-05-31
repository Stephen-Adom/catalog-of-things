require 'rspec'
require_relative '../classes/game'

RSpec.describe Game do
  let(:author) { Author.new('John', 'Doe') }
  let(:publish_date) { Date.new(2010, 1, 1) }
  let(:game) { Game.new('Action', author, 'Game Label', publish_date, true, Date.new(2021, 1, 1)) }

  describe '#can_be_archived?' do
    context 'when the game is older than 10 years and last played more than two years ago' do
      it 'returns true' do
        expect(game.can_be_archived?).to be(true)
      end
    end

    context 'when the game is older than 10 years but last played within two years' do
      before { game.last_played_at = Date.today }

      it 'returns false' do
        expect(game.can_be_archived?).to be(false)
      end
    end

    context 'when the game is not older than 10 years but last played more than two years ago' do
      before { game.publish_date = Date.today }

      it 'returns false' do
        expect(game.can_be_archived?).to be(false)
      end
    end

    context 'when the game is not older than 10 years and last played within two years' do
      before do
        game.publish_date = Date.today
        game.last_played_at = Date.today
      end

      it 'returns false' do
        expect(game.can_be_archived?).to be(false)
      end
    end
  end
end
