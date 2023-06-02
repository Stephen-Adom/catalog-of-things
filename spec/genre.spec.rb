require 'rspec'
require_relative '../classes/music'
require_relative '../classes/genre'
require_relative '../classes/label'
require_relative '../classes/author'

describe Genre do
  let(:genre) { Genre.new('Pop') }
  let(:author) { Author.new('J.K.', 'Rowling') }
  let(:label) { Label.new('test') }
  let(:album) { MusicAlbum.new(genre, author, label, true, '2022-05-05') }

  describe '#initialize' do
    it 'should create a new Genre with the given name' do
      genre = Genre.new('Pop')
      expect(genre.name).to eq('Pop')
      expect(genre.items).to be_empty
    end
  end

  describe '#add_item' do
    it 'should add the given item to the Genre' do
      genre.add_item(album)

      expect(genre.items).to include(album)
      expect(album.genre).to eq(genre)
    end
  end
end
