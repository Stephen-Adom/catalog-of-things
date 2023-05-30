require_relative '../classes/book'
require_relative '../classes/label'
module BookModule
  def book_info
    # enter book label
    print 'Enter book label (e.g Gift, New): '
    input_label = gets.chomp

    # enter book author
    print 'Enter book author (e.g Stephen King) : '
    input_author = gets.chomp

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
    label_obj = create_book_label(book_object[:label])
    author_obj = create_book_author(book_object[:author])
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

  def create_book_label(title)
    if @all_labels.empty?
      create_label_obj(title)
    else
      label_exist = @all_labels.find { |label| label.title == title }
      label_exist.nil? ? create_label_obj(title) : label_exist
    end
  end

  def create_label_obj(title)
    new_label = Label.new(title)
    @all_labels << new_label
    new_label.save_label_to_json(@all_labels)
    new_label
  end

  def create_book_author(name)
    if @all_authors.empty?
      create_author_obj(name)
    else
      author_exist = @all_authors.find { |author| create_author_full_name(author.first_name, author.last_name) == name }
      author_exist.nil? ? create_author_obj(title) : author_exist
    end
  end

  def create_author_obj(name)
    names = name.split
    new_author = Author.new(names[0].strip, names[1]&.strip)
    @all_authors << new_author
    new_author.save_author_to_json(@all_authors)
    new_author
  end

  def create_author_full_name(firstname, lastname)
    "#{firstname} #{lastname}"
  end

  def create_book_genre(name)
    new_genre = Genre.new(name)
    @all_genres << new_genre
    new_genre.save_genre_to_json(@all_genres)
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
    if @all_labels.empty?
      puts "No labels available!!!\n\n"
    else
      @all_labels.each { |label| puts "Id: #{label.id} Label: #{label.title} Color: #{label.color}" }
      puts "\n"
    end
  end
end
