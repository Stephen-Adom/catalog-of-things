require 'json'
require_relative 'modules/books.module'
require_relative 'modules/data.module'
require_relative './modules/game_logic'
require_relative './modules/author_logic'
require_relative './classes/music_album_app'
require_relative './classes/files_handler'
require_relative './classes/genre_app'
class App
  attr_accessor :option, :all_books, :all_labels, :all_authors, :all_genres

  include BookModule
  include LoadData
  include DisplayItem

  def initialize
    @all_books = []
    @all_labels = []
    @all_genres = []
    @all_authors = []
    @all_genres = []
    load_data
  end

  def app_options
    puts "Welcome to Catalog App!\n"
    puts 'Please choose an option by entering a number:'
    puts '1 - List all books'
    puts '2 - List all music albums'
    puts '3 - List all games'
    puts '4 - List all genres (e.g Comedy, Thriller)'
    puts '5 - List all labels (e.g Gift, New)'
    puts '6 - List all authors (e.g Stephen King)'
    puts '7 - Add a book'
    puts '8 - Add a music album'
    puts '9 - Add a game'
    puts '10 - Exit'
    print 'Your option '
    @option = gets.chomp
  end

  def check_option(option)
    if (1..5).include?(option.to_i)
      case option.to_i
      when 1
        list_all_books
      when 2
        MusicAlbumApp.list_albums
      when 3
        GameLogic.list_games
      when 4
        GenreApp.list_genres
      when 5
        list_all_labels
      end
    else

      check_option_two(option.to_i)
    end
  end

  def check_option_two(option)
    case option
    when 6
      AuthorLogic.list_authors
    when 7
      book_info
    when 8
      MusicAlbumApp.add_album
    when 9
      GameLogic.add_game
    end
  end

  def run
    GenreApp.load_genres
    MusicAlbumApp.load_albums
    loop do
      app_options

      unless (1..10).include?(@option.to_i)
        puts "Your input is invalid. Please enter then correct option value........\n"
      end

      if @option.to_i == 10
        puts 'Thank you for using the app....'
        break
      end

      check_option(@option)
    end
  end
end
