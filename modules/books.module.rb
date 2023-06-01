require_relative '../classes/book'
require_relative '../classes/label'
require_relative '../classes/genre'
require_relative '../modules/author_logic'
require_relative '../modules/label_logic'

module BookModule
  def book_info
    # enter book label
    input_label = LabelLogic.new.add_label

    # enter book author
    input_author = AuthorLogic.find_or_create_author

    print 'Enter book genre(e.g Comedy, Thriller): '
    input_genre = gets.chomp

    # enter book publisher
    print 'Enter publisher: '
    publisher = gets.chomp

    # enter book published date
    print 'Enter published date (YYYY-MM-DD): '
    published_date = gets.chomp

    print 'Enter cover state (good/bad): '
    cover_state = gets.chomp

    create_book_object({
                         label: input_label,
                         author: input_author,
                         genre: input_genre,
                         publisher: publisher,
                         published_date: published_date,
                         cover_state: cover_state
                       })
  end

  def create_book_object(book_object)
    label_obj = book_object[:label]
    author_obj = book_object[:author]
    genre_obj = create_book_genre(book_object[:genre])
    new_book = Book.new(genre_obj, author_obj, label_obj, Date.parse(book_object[:published_date]),
                        book_object[:publisher])

    new_book.update_cover_state(book_object[:cover_state])

    save_book(new_book)
  end

  def save_book(book)
    @all_books << book
    book.save_books_to_json(@all_books)
  end

  def create_author_full_name(firstname, lastname)
    "#{firstname} #{lastname}"
  end

  def create_book_genre(name)
    if @all_genres.empty?
      create_genre_obj(name)
    else
      genre_exist = @all_genres.find { |genre| genre.name == name }
      genre_exist.nil? ? create_genre_obj(name) : genre_exist
    end
  end

  def create_genre_obj(name)
    new_genre = GenreApp.create(name)
    @all_genres << new_genre
    GenreApp.save_genre_to_json(@all_genres)
    new_genre
  end
end

module DisplayItem
  def list_all_books
    if @all_books.empty?
      puts "No Books available!!!\n\n"
    else
      @all_books.each do |book|
        puts combine_book_info(book)
      end
      puts "\n"
    end
  end

  def combine_book_info(book)
    print "Id: #{book.id} "
    print "Genre: #{book.genre.name} "
    print "Author: #{create_author_full_name(book.author.first_name, book.author.last_name)} "
    print "Label: #{book.label.title} "
    print "Publish-date: #{book.publish_date} "
    print "Publisher: #{book.publisher} "
    print "cover state: #{book.cover_state}"
  end

  def list_all_labels
    all_labels = LabelLogic.new.load_labels

    if all_labels.empty?
      puts "No labels available!!!\n\n"
    else
      all_labels.each { |label| puts "Id: #{label.id} Label: #{label.title} Color: #{label.color}" }
      puts "\n"
    end
  end
end
