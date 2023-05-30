require_relative '../item'
require_relative 'author_logic'
require 'json'

class GameLogic
  def self.list_games
    games = load_games
    puts 'List of Games:'
    games.each_with_index do |game, index|
      puts "#{index + 1}. ID: #{game['id']}, Archived: #{game['archived']}, Genre: #{game['genre']}, Author: #{game['author']}, Source: #{game['source']}, Label: #{game['label']}, Publish Date: #{game['publish_date']}, Multiplayer: #{game['multiplayer']}, Last Played At: #{game['last_played_at']}"
    end
  end

  def self.add_game
    puts 'Enter game details:'
    print 'Genre: '
    genre = gets.chomp
    author = AuthorLogic.find_or_create_author
    print 'Source: '
    source = gets.chomp
    print 'Label: '
    label = gets.chomp
    print 'Publish date (YYYY-MM-DD): '
    publish_date = gets.chomp
    print 'Multiplayer (true/false): '
    multiplayer = gets.chomp.downcase == 'true'
    print 'Last played at (YYYY-MM-DD): '
    last_played_at = gets.chomp

    game = Game.new(genre, author, source, label, publish_date, multiplayer, Date.parse(last_played_at))
    save_game(game)
  end

  def self.save_game(game)
    games = load_games
    games << serialize_game(game)
    File.open('games.json', 'w') { |file| file.write(JSON.generate(games)) }
    puts 'Game saved successfully.'
  end

  private

  def self.serialize_game(game)
    {
      id: game.id,
      archived: game.archived,
      genre: game.genre,
      author: "#{game.author.first_name} #{game.author.last_name}",
      source: game.source,
      label: game.label,
      publish_date: game.publish_date.to_s,
      multiplayer: game.multiplayer,
      last_played_at: game.last_played_at.to_s
    }
  end

  def self.load_games
    if File.exist?('games.json')
      games_data = File.read('games.json')
      games_data.empty? ? [] : JSON.parse(games_data)
    else
      []
    end
  end
end
