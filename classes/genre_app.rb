require_relative './files_handler'
require_relative './genre'

class GenreApp
  @genres = []
  @file_name = 'genres.json'

  class << self
    attr_reader :genres

    def create(name)
      new_genre = Genre.new(name)
      @genres << new_genre
      new_genre
    end

    def add_genre
      puts 'Creating a genre....'
      print 'Enter name of genre: '
      name = gets.chomp
      genre = create(name)
      puts 'Genre created successfully'
      genre
    end

    def list_all
      puts "Loading all genres ... \n"
      return puts 'No music genres found' if @genres.empty?

      genre_data = Storage.read_file_content(@file_name)
      genre_data.each_with_index do |genre, index|
        puts "#{index}) Name: #{genre['name']}"
      end
    end

    def save_genres
      genres = []
      puts @genres
      @genres.each do |genre|
        albums = []
        genre.items.map do |album|
          albums << { album_id: album.id }
        end
        genres.push({ id: genre.id, name: genre.name, music_album: albums })
      end
      Storage.save_file_content(@file_name, genres)
    end
  end
end
