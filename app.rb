require 'json'
require_relative 'modules/books.module'
require_relative 'modules/data.module'

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
  end

  def app_options
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
    case option.to_i
    when 1
      list_all_books
    when 5
      list_all_labels
    when 7
      book_info
    end
  end

  def run
    load_data
    puts @all_books.length
    loop do
      app_options

      unless (1..10).include?(@option.to_i)
        puts "Your input is invalid. Please enter then correct option value........\n"
      end

      if @option.to_i == 10
        # save_books
        puts 'Thank you for using the app....'
        break
      end

      check_option(@option)
    end
  end
end
