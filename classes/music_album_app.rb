require_relative './files_handler'
require_relative './genre_app'
require_relative './music'
require_relative './label'
require_relative './author'

class MusicAlbumApp
  @music_albums = []
  @file_name = 'music_albums.json'

  class << self
    attr_reader :music_albums

    def create(genre, author, label, on_spotify, publish_date)
      new_album = MusicAlbum.new(genre, author, label, on_spotify, publish_date)
      @music_albums << new_album
      new_album
    end

    def add_album
      print 'Enter publish date as (yyyy-mm-dd): '
      publish_date = gets.chomp
      print 'Is it on shopify ? Enter YES(Y) and NO(N): '
      on_spotify = gets.chomp
      on_spotify = on_spotify.upcase == 'Y'
      genre = GenreApp.add_genre
      print 'Enter author first name: '
      first_name = gets.chomp
      print 'Enter authorast name: '
      last_name = gets.chomp
      print 'Adding a label title: '
      label_title = gets.chomp

      label = Label.new(label_title)
      author = Author.new(first_name, last_name)
      music_album = create(genre, author, label, on_spotify, publish_date)
      genre.add_item(music_album) unless genre.items.include?(music_album)
      label.add_item(music_album)
      author.add_item(music_album)
      save_albums
      GenreApp.save_genres
    end

    def list_albums
      puts "\nListing music albums ...\n"
      load_albums
      return puts 'There are no music albums' unless music_albums.length.positive?

      @music_albums.each_with_index do |album, index|
        print "#{index}) Publish Date: #{album.publish_date}, "
        print "On Spotify: #{album.on_spotify}, Genre: #{album.genre.name}"
      end
      puts "\n"
    end

    def load_albums
      puts "Loading albums ... \n\n"
      return @music_albums unless @music_albums.empty?

      album_data = Storage.read_file_content(@file_name)
      album_data.each do |album|
        new_album = create(album['on_spotify'], album['publish_date'])
        new_album.genre = GenreApp.create(album['genre']['name'])
      end
      @music_albums
    end

    def save_albums
      albums = []
      @music_albums.each do |item|
        albums.push({ id: item.id, publish_date: item.publish_date,
                      on_spotify: item.on_spotify, archived: item.archived,
                      genre: { name: item.genre.name } })
      end
      Storage.save_file_content(@file_name, albums)
    end
  end
end
