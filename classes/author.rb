class Author
  attr_reader :id, :items
  attr_accessor :first_name, :last_name

  def initialize(first_name, last_name)
    @id = generate_id
    @first_name = first_name
    @last_name = last_name
    @items = []
  end

  def add_item(item)
    @items << item unless @items.include?(item)
    item.author = self
  end

  def save_author_to_json(all_authors)
    File.write('data/authors.json', JSON.dump({
                                                data: all_authors.map do |author|
                                                  {
                                                    id: author.id,
                                                    first_name: author.first_name,
                                                    last_name: author.last_name
                                                  }
                                                end
                                              }))
  end

  private

  def generate_id
    (rand * 1000).floor
  end
end
