require 'rspec'
require_relative '../classes/music'

describe MusicAlbum do
  before :each do
    @album = MusicAlbum.new(true, '2022-05-05')
  end

  it 'should create a new MusicAlbum with the given title, genre, and on_spotify' do
    expect(@album.publish_date).to eq('2022-05-05')
    expect(@album.on_spotify).to eq(true)
  end

  it 'should be an instance of MusicAlbum' do
    album = MusicAlbum.new(true, '2022-05-05')
    expect(album).to be_instance_of MusicAlbum
  end
end
