require_relative '../app'
require_relative '../classes/label'
require_relative '../classes/files_handler'
require_relative '../classes/genre'
require_relative '../classes/author'

describe 'App' do
  let(:app) { App.new }

  context '#create_author_full_name' do
    it 'should create author full name' do
      expect(app.create_author_full_name('J.K.', 'Rowling')).to eql 'J.K. Rowling'
    end
  end
end
