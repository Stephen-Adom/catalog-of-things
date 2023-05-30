require 'json'

class App
  attr_accessor :option

  def app_options
    puts 'Please choose an option by entering a number:'
    puts '1 - List all books'
    puts '2 - List all music albums'
    puts '3 - List all movies'
    puts '4 - List all games'
    puts '5 - List all genres (e.g Comedy, Thriller)'
    puts '6 - List all labels (e.g Gift, New)'
    puts '7 - List all authors (e.g Stephen King)'
    puts '8 - List all sources (e.g From a friend, Online shop)'
    puts '9 - Add a book'
    puts '10 - Add a music album'
    puts '11 - Add a movie'
    puts '12 - Add a game'
    puts '13 - Exit'
    print 'Your option: '
    @option = gets.chomp.to_i
  end

  def check_option(option)
    case option
    when 4
      list_games
    when 7
      list_authors
    when 12
      add_game
    else
      puts 'Invalid option'
    end
  end

  def list_games
    games = load_games
    games.each_with_index do |game, index|
      puts "#{index + 1}. ID: #{game['id']}, Archived: #{game['archived']}, Genre: #{game['genre']}, Author: #{game['author']}, Source: #{game['source']}, Label: #{game['label']}, Publish Date: #{game['publish_date']}, Multiplayer: #{game['multiplayer']}, Last Played At: #{game['last_played_at']}"
    end
  end

  def list_authors
    authors = load_authors
    authors.each { |author| puts author }
  end

  def add_game
    puts 'Enter game details:'
    print 'Genre: '
    genre = gets.chomp
    print 'Author: '
    author = gets.chomp
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


  def save_game(game)
    games = load_games
    games << serialize_game(game)
    File.open('games.json', 'w') { |file| file.write(JSON.generate(games)) }
    puts 'Game saved successfully.'
  end

  private

  def serialize_game(game)
    {
      id: game.id,
      archived: game.archived,
      genre: game.genre,
      author: game.author,
      source: game.source,
      label: game.label,
      publish_date: game.publish_date.to_s,
      multiplayer: game.multiplayer,
      last_played_at: game.last_played_at.to_s
    }
  end

  def load_games
    if File.exist?('games.json')
      games_data = File.read('games.json')
      games_data.empty? ? [] : JSON.parse(games_data)
    else
      []
    end
  end

  def save_authors(authors)
    File.open('authors.json', 'w') { |file| file.write(authors.to_json) }
    puts 'Authors saved successfully.'
  end

  def load_authors
    if File.exist?('authors.json')
      JSON.parse(File.read('authors.json'))
    else
      []
    end
  end

  public

  def run
    loop do
      app_options
  
      unless (1..13).include?(@option.to_i)
        puts "Your input is invalid. Please enter a correct option value.\n"
        next
      end
  
      if @option.to_i == 13
        puts 'Thank you for using the app.'
        break
      end
  
      check_option(@option.to_i)
    end
  end
end