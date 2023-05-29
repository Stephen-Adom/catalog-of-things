require_relative '../classes/book'

module ListBookComponents
  def list_available_labels
    return if @all_labels.empty?

    @all_labels.each_with_index do |label, index|
      puts "#{index}) - #{label[:title]} #{label[:color]}"
    end
  end

  def list_available_authors
    return if @all_authors.empty?

    @all_authors.each_with_index do |author, index|
      puts "#{index}) - #{author[:first_name]} #{author[:last_name]}"
    end
  end

  def list_available_genres
    return if @all_genres.empty?

    @all_genres.each_with_index do |genre, index|
      puts "#{index}) - #{genre[:name]}"
    end
  end
end

module ValidateUserInput
  def label_info_input
    selected_label = nil

    loop do
      puts 'Select a book by number: '
      list_available_labels
      input_label = gets.chomp.to_i

      selected_label = @all_labels[input_label]

      break if selected_label

      puts "Selected book not available!!\n\n"
    end
    selected_label
  end

  def author_info_input
    selected_author = nil
    loop do
      puts 'Select an author by number: '
      list_available_authors
      input_author = gets.chomp.to_i

      selected_author = @all_authors[input_author]

      break if selected_author

      puts "Selected author not available!!\n\n"
    end
    selected_author
  end

  def genre_info_input
    selected_genre = nil

    loop do
      puts 'Select genre by number: '
      list_available_genres
      input_genre = gets.chomp.to_i

      selected_genre = @all_genres[input_genre]

      break if selected_genre

      puts "Selected genre not available!!\n\n"
    end

    selected_genre
  end

  def cover_info_input
    # enter book cover state
    cover_state = nil
    loop do
      print 'Enter cover state (1) good (2) bad ? [Input the number]: '
      cover_state = gets.chomp.to_i

      break if (1..2).include?(cover_state)

      puts "Invalid input. Please select either 1) or 2)!!!\n\n"
    end

    cover_state == 1 ? 'good' : 'bad'
  end
end

module BookModule
  include ListBookComponents
  include ValidateUserInput

  def display_book_component
    # select book label
    selected_label = label_info_input

    # select book author
    selected_author = author_info_input

    # select book genre
    selected_genre = genre_info_input

    {
      label: selected_label,
      author: selected_author,
      genre: selected_genre
    }
  end

  def book_info
    # get book components
    book_components = display_book_component

    # enter book publisher
    print 'Enter publisher: '
    publisher = gets.chomp

    # enter book published date
    print 'Enter published date (YYYY-MM-DD): '
    published_date = gets.chomp

    cover_state = cover_info_input

    create_book_object({
                         label: book_components[:label],
                         author: book_components[:author],
                         genre: book_components[:genre],
                         publisher: publisher,
                         published_date: published_date,
                         cover_state: cover_state
                       })
  end

  def create_book_object(book_object)
    new_book = Book.new(book_object[:genre], book_object[:author], book_object[:label],
                        book_object[:published_date], book_object[:publisher], book_object[:cover_state])
    add_a_book(new_book)
  end
end

module DisplayItem
  def list_all_books
    if @all_books.empty?
      puts "No Books available!!!\n\n"
    else
      @all_books.each { |book| puts "#{book.label[:title]}" }
      puts "\n\n"
    end
  end

  def list_all_labels
    if @all_labels.empty?
      puts "No labels available!!!\n\n"
    else
      @all_labels.each { |label| puts "Label: #{label[:title]} Color: #{label[:color]}" }
      puts "\n\n"
    end
  end
end
