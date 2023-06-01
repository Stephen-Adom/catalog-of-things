require_relative '../classes/game'

describe Game do
  let(:genre) { 'Action' }
  let(:author) { 'John Doe' }
  let(:label) { 'Game Publisher' }
  let(:publish_date) { Date.new(2010, 1, 1) }

  describe '#initialize' do
    it 'creates a new Game object' do
      game = Game.new(genre, author, label, publish_date)
      expect(game).to be_an_instance_of(Game)
      expect(game.genre).to eq(genre)
      expect(game.author).to eq(author)
      expect(game.label).to eq(label)
      expect(game.publish_date).to eq(publish_date)
      expect(game.multiplayer).to be_nil
      expect(game.last_played_at).to be_nil
    end

    it 'creates a new Game object with multiplayer and last_played_at options' do
      options = { multiplayer: true, last_played_at: Date.new(2022, 1, 1) }
      game = Game.new(genre, author, label, publish_date, options)
      expect(game.multiplayer).to eq(true)
      expect(game.last_played_at).to eq(Date.new(2022, 1, 1))
    end
  end

  describe '#can_be_archived?' do
    context 'when the game is eligible for archiving' do
      it 'returns true' do
        options = { multiplayer: true, last_played_at: Date.new(2018, 1, 1) }
        game = Game.new(genre, author, label, publish_date, options)
        expect(game.can_be_archived?).to be(true)
      end
    end

    context 'when the game is not eligible for archiving' do
      it 'returns false' do
        options = { multiplayer: true, last_played_at: Date.today }
        game = Game.new(genre, author, label, publish_date, options)
        expect(game.can_be_archived?).to be(false)
      end
    end
  end
end
