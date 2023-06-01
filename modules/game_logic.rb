require_relative '../classes/item'
require_relative '../classes/genre_app'
require_relative 'author_logic'
require_relative './label_logic'
require 'json'
require 'fileutils'

class GameLogic
  DATA_FOLDER = 'data'.freeze
  GAMES_FILE = File.join(DATA_FOLDER, 'games.json').freeze

  def self.list_games
    games = load_games
    puts 'List of Games:'
    games.each_with_index do |game, index|
      puts "#{index + 1}. ID: #{game['id']}, Archived: #{game['archived']}, Genre: #{game['genre']}, " \
           "Author: #{game['author']}, Label: #{game['label']}, Publish Date: #{game['publish_date']}, " \
           "Multiplayer: #{game['multiplayer']}, Last Played At: #{game['last_played_at']}"
    end
  end

  def self.add_game
    puts 'Enter game details:'
    print 'Genre: '
    genre = GenreApp.add_genre

    label = LabelLogic.new.add_label
    print 'Publish date (YYYY-MM-DD): '
    publish_date = gets.chomp
    print 'Multiplayer (true/false): '
    multiplayer = gets.chomp.downcase == 'true'
    print 'Last played at (YYYY-MM-DD): '
    last_played_at = gets.chomp
    author = AuthorLogic.find_or_create_author

    game = Game.new(genre, author, label, publish_date, multiplayer: multiplayer, last_played_at: last_played_at)
    save_game(game)
  end

  def self.save_game(game)
    games = load_games
    games << serialize_game(game)
    File.write(GAMES_FILE, JSON.generate(games))
    puts 'Game saved successfully.'
  end

  def self.serialize_game(game)
    {
      id: game.id,
      archived: game.archived,
      genre: game.genre.name.to_s,
      author: "#{game.author.first_name} #{game.author.last_name}",
      label: game.label.title.to_s,
      publish_date: game.publish_date.to_s,
      multiplayer: game.multiplayer,
      last_played_at: game.last_played_at.to_s
    }
  end

  def self.load_games
    FileUtils.mkdir_p(DATA_FOLDER) unless File.directory?(DATA_FOLDER)
    if File.exist?(GAMES_FILE)
      games_data = File.read(GAMES_FILE)
      games_data.empty? ? [] : JSON.parse(games_data)
    else
      []
    end
  end
end
