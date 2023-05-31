require_relative '../classes/logic/author_logic'

RSpec.describe AuthorLogic do
  describe '.list_authors' do
    it 'prints the list of authors' do
      expect { AuthorLogic.list_authors }.to output(/List of Authors:/).to_stdout
    end
  end

  describe '.serialize_author' do
    it 'serializes the author object' do
      author = double('Author', id: 1, first_name: 'John', last_name: 'Doe')
      serialized_author = AuthorLogic.serialize_author(author)
      expect(serialized_author).to eq({ id: 1, first_name: 'John', last_name: 'Doe' })
    end
  end
end
