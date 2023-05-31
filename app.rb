require_relative './modules/game_logic'
require_relative './modules/author_logic'

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
    puts '8 - Add a book'
    puts '9 - Add a music album'
    puts '10 - Add a movie'
    puts '11 - Add a game'
    puts '12 - Exit'
    print 'Your option: '
    @option = gets.chomp.to_i
  end

  def check_option(option)
    case option
    when 4
      GameLogic.list_games
    when 7
      AuthorLogic.list_authors
    when 11
      GameLogic.add_game
    else
      puts 'Invalid option'
    end
  end

  def run
    loop do
      app_options

      unless (1..12).include?(@option.to_i)
        puts "Your input is invalid. Please enter a correct option value.\n"
        next
      end

      if @option.to_i == 12
        puts 'Thank you for using the app.'
        break
      end

      check_option(@option.to_i)
    end
  end
end
