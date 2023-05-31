require 'rspec'
require_relative '../classes/music'
require_relative '../classes/genre'
require_relative '../classes/label'
require_relative '../classes/author'

describe MusicAlbum do
  before :each do
    @genre = Genre.new('Pop')
    @author = Author.new('J.K.', 'Rowling')
    @label = Label.new('test')
    @album = MusicAlbum.new(@genre, @author, @label, true, '2022-05-05')
  end

  it 'should create a new MusicAlbum with the given title, genre, and on_spotify' do
    expect(@album.publish_date).to eq('2022-05-05')
    expect(@album.on_spotify).to eq(true)
  end

  it 'should be an instance of MusicAlbum' do
    expect(@album).to be_instance_of(MusicAlbum)
  end
end
