require_relative '../modules/game_logic'

require_relative '../classes/game'
require_relative '../classes/author'

RSpec.describe GameLogic do
  let(:author) { Author.new('John', 'Doe') }
  let(:publish_date) { Date.new(2020, 1, 1) }
  let(:game) { Game.new('Action', author, 'Game Label', publish_date) }

  describe '.serialize_game' do
    it 'returns a serialized hash representation of the game' do
      serialized_game = GameLogic.serialize_game(game)
      expect(serialized_game).to be_a(Hash)
      expect(serialized_game[:id]).to eq(game.id)
      expect(serialized_game[:archived]).to eq(game.archived)
      expect(serialized_game[:genre]).to eq(game.genre)
      expect(serialized_game[:author]).to eq("#{game.author.first_name} #{game.author.last_name}")
      expect(serialized_game[:label]).to eq(game.label)
      expect(serialized_game[:publish_date]).to eq(game.publish_date.to_s)
      expect(serialized_game[:multiplayer]).to eq(game.multiplayer)
      expect(serialized_game[:last_played_at]).to eq(game.last_played_at.to_s)
    end
  end
end
