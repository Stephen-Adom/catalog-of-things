require_relative './files_handler'
require_relative './genre_app'
require_relative './music'

class MusicAlbumApp
  @music_albums = []
  @file_name = 'music_albums.json'

  class << self
    attr_reader :music_albums

    def create(on_spotify, publish_date)
      new_album = MusicAlbum.new(on_spotify, publish_date)
      @music_albums << new_album
      new_album
    end

    def add_album
      puts 'Creating Music Album...'
      print 'Enter publish date as (yyyy-mm-dd): '
      publish_date = gets.chomp
      print 'Is it on shopify ? Enter YES(Y) and NO(N): '
      on_spotify = gets.chomp
      on_spotify = on_spotify.upcase == 'Y'
      puts 'Please add genre for your music album'
      genre = GenreApp.add_genre
      music_album = create(on_spotify, publish_date)
      music_album.genre = genre
      genre.add_item(music_album) unless genre.items.include?(music_album)
      save_albums
      GenreApp.save_genres
    end

    def list_albums
      puts "Listing music albums ...\n"
      load_albums
      return puts 'There are no music albums' unless music_albums.length.positive?

      @music_albums.each_with_index do |album, index|
        puts album.inspect
        puts "#{index}) Publish Date: #{album.publish_date}, On Spotify: #{album.on_spotify}, Genre: #{album.genre.name}"
      end
    end

    def load_albums
      puts "Loading albums ... \n"
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
        albums.push({ id: item.id, publish_date: item.publish_date, on_spotify: item.on_spotify, archived: item.archived,
                      genre: { name: item.genre.name } })
      end
      Storage.save_file_content(@file_name, albums)
    end
  end
end
