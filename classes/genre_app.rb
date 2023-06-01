require_relative './files_handler'
require_relative './genre'

class GenreApp
  @genres = []
  @file_name = 'genres.json'

  class << self
    attr_reader :genres

    def create(name)
      genre = @genres.find { |a| a.name == name }
      return genre unless genre.nil?

      new_genre = Genre.new(name)
      @genres << new_genre
      save_genres
      new_genre
    end

    def add_genre
      puts 'Adding a genre ...'
      print 'Name: '
      name = gets.chomp
      genre = create(name)
      puts 'Genre created successfully'
      genre
    end

    def list_genres
      puts "Loading all genres ... \n"

      return puts 'No music genres found' if @genres.empty?

      @genres.each_with_index do |genre, index|
        puts "#{index}) Name: #{genre.name}"
      end
    end

    def load_genres
      puts "Loading albums ... \n\n"

      return @genres unless @genres.empty?

      genres = Storage.read_file_content(@file_name)
      genres.each do |genre|
        new_genre = Genre.new(genre['name'])
        new_genre.update_id(genre['id'])
        @genres << new_genre
      end
      @genres
    end

    def save_genres
      genres = []
      @genres.each do |genre|
        albums = []
        genre.items.map do |album|
          albums << { album_id: album.id }
        end
        genres.push({ id: genre.id, name: genre.name, music_album: albums })
      end
      Storage.save_file_content(@file_name, genres)
    end

    def save_genre_to_json(all_genres)
      File.write('data/genres.json', JSON.dump(
                                       all_genres.map do |genre|
                                         {
                                           id: genre.id,
                                           name: genre.name,
                                           items: []
                                         }
                                       end
                                     ))
    end
  end
end
