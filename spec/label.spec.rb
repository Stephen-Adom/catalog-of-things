require_relative '../classes/book'
require_relative '../classes/label'
require_relative '../classes/genre'
require_relative '../classes/author'
require 'json'

describe 'Label' do
  let(:genre) { Genre.new('Fiction') }
  let(:author) { Author.new('J.K.', 'Rowling') }
  let(:label) { Label.new('test') }
  let(:book) do
    Book.new(genre, author, label, Date.new(1997, 11, 11),
             'Bloomsbury')
  end

  context '#title' do
    it 'should have a title' do
      expect(label.title).to eq 'test'
    end
  end

  context '#add_item' do
    it 'adds an item to the label' do
      label.add_item(book)
      expect(label.items.length).to eq 1
    end
  end

  context '#update_id' do
    it 'updates the id of the label' do
      label.update_id(1)
      expect(label.id).to eq 1
    end
  end
end
