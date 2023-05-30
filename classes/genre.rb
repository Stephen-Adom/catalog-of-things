class Genre
  attr_reader :id, :items
  attr_accessor :name

  def initialize(name)
    @id = generate_id
    @name = name
    @items = []
  end

  def add_item(item)
    @items << item unless @items.include?(item)
    item.genre = self
  end

  def save_genre_to_json(all_genres)
    File.write('data/genres.json', JSON.dump({
                                               data: all_genres.map do |genre|
                                                 {
                                                   id: genre.id,
                                                   name: genre.name
                                                 }
                                               end
                                             }))
  end

  private

  def generate_id
    (rand * 1000).floor
  end
end
