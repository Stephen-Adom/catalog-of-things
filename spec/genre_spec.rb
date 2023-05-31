require 'rspec'
require_relative '../classes/music'
require_relative '../classes/genre'

describe Genre do
  describe '#initialize' do
    it 'should create a new Genre with the given name' do
      genre = Genre.new('Pop')
      expect(genre.name).to eq('Pop')
      expect(genre.items).to be_empty
    end
  end

  describe '#add_item' do
    it 'should add the given item to the Genre' do
      genre = Genre.new('Pop')
      album = MusicAlbum.new(true, '2022-05-05')
      album.genre = genre

      genre.add_item(album)

      expect(genre.items).to include(album)
      expect(album.genre).to eq(genre)
      expect(album.genre.name).to eq('Pop')
    end
  end
end
