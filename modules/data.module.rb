require 'json'

module LoadData
  def load_data
    load_genres
    load_authors
    load_labels
    load_books
  end

  def load_labels
    return unless File.exist?('./data/label.json')

    return if File.empty?('./data/books.json')

    File.open('./data/label.json', 'r') do |file|
      label_data = JSON.parse(file.read)['data']
      label_data.map do |data|
        label_obj = Label.new(data['title'], data['color'])

        label_obj.update_id(data['id'])

        @all_labels << label_obj
      end
    end
  end

  def load_books
    return unless File.exist?('./data/books.json')

    return if File.empty?('./data/books.json')

    File.open('./data/books.json') do |file|
      books_data = JSON.parse(file.read)['data']

      books_data.map do |book|
        label = @all_labels.find { |data| data.id == book['label'] }
        author = @all_authors.find { |data| data.id == book['author'] }
        genre = @all_genres.find { |data| data.id == book['genre'] }

        new_book = Book.new(genre, author, label,
                            Date.parse(book['publish_date']), book['publisher'])
        new_book.update_id(book['id'])
        new_book.update_cover_state(book['cover_state'])

        @all_books << new_book
      end
    end
  end

  def load_authors
    return if File.empty?('./data/authors.json')

    return if File.empty?('./data/authors.json')

    authors_data = AuthorLogic.load_authors

    authors_data.map do |author|
      new_author = Author.new(author['first_name'], author['last_name'])
      new_author.update_id(author['id'])

      @all_authors << new_author
    end
  end

  def load_genres
    return unless File.exist?('./data/genres.json')

    return if File.empty?('./data/genres.json')

    genres_data = Storage.read_file_content('genres.json')

    genres_data.map do |genre|
      new_genre = Genre.new(genre['name'])
      new_genre.update_id(genre['id'])

      @all_genres << new_genre
    end
  end
end
