require_relative '../classes/logic/game_logic'

RSpec.describe GameLogic do
  describe '.list_games' do
    it 'prints the list of games' do
      expect { GameLogic.list_games }.to output(/List of Games:/).to_stdout
    end
  end

  describe '.serialize_game' do
    it 'serializes the game object' do
      author = double('Author', first_name: 'John', last_name: 'Doe')
      game = double('Game', id: 1, archived: false, genre: 'Action', author: author, label: 'Game 1',
                            publish_date: '2023-05-30', multiplayer: true, last_played_at: '2023-05-31')
      serialized_game = GameLogic.serialize_game(game)
      expect(serialized_game).to eq({
                                      id: 1,
                                      archived: false,
                                      genre: 'Action',
                                      author: 'John Doe',
                                      label: 'Game 1',
                                      publish_date: '2023-05-30',
                                      multiplayer: true,
                                      last_played_at: '2023-05-31'
                                    })
    end
  end
end
