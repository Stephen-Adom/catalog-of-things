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
    print 'Your option '
    @option = gets.chomp
  end

  def check_option(option); end

  def run
    loop do
      app_options

      unless (1..13).include?(@option.to_i)
        puts "Your input is invalid. Please enter then correct option value........\n"
      end

      if @option.to_i == 13
        puts 'Thank you for using the app....'
        break
      end

      check_option(@option)
    end
  end
end
