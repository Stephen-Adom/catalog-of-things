require_relative '../classes/game'

require_relative '../classes/game'
require_relative '../classes/author'

RSpec.describe Game do
  let(:author) { Author.new('John', 'Doe') }
  let(:publish_date) { Date.new(2020, 1, 1) }
  let(:game) { Game.new('Action', author, 'Game Label', publish_date) }

  describe '#can_be_archived?' do
    it 'returns true if the game can be archived' do
      allow(Date).to receive(:today).and_return(Date.new(2032, 1, 1))
      allow(game).to receive(:last_played_more_than_two_years_ago?).and_return(true)
      expect(game.can_be_archived?).to be true
    end

    it 'returns false if the game cannot be archived' do
      allow(Date).to receive(:today).and_return(Date.new(2025, 1, 1))
      allow(game).to receive(:last_played_more_than_two_years_ago?).and_return(false)
      expect(game.can_be_archived?).to be false
    end
  end
end
