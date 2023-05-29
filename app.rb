class App
  attr_accessor :option

  def app_options
    puts 'Please choose an option by entering a number:'
    puts "1 - List all books\n2 - List all music albums\n3 - List all movies\n4 - List all games\n5 - List all genres (e.g Comedy, Thriller)\n6 - List all labels (eg Gift, New)\n7 - List all authors (eg Stephen King)\n8 - List all sources (eg From a friend, Online shop)\n9 - Add a book\n10 - Add a music album\n11 - Add a movie\n12 - Add a game\n13 - Exit"
    print 'Your option '
    @option = gets.chomp
  end

  def check_option(option); end

  def run
    loop do
      app_options

      unless (1..7).include?(@option.to_i)
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
