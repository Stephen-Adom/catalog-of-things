require_relative '../modules/author_logic'

require_relative '../classes/author'

RSpec.describe AuthorLogic do
  describe '.serialize_author' do
    it 'returns a serialized hash representation of the author' do
      author = Author.new('John', 'Doe')
      serialized_author = AuthorLogic.serialize_author(author)
      expect(serialized_author).to be_a(Hash)
      expect(serialized_author[:id]).to eq(author.id)
      expect(serialized_author[:first_name]).to eq(author.first_name)
      expect(serialized_author[:last_name]).to eq(author.last_name)
    end
  end
end
