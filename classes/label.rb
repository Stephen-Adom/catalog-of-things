class Label
  attr_reader :id, :items
  attr_accessor :title, :color

  def initialize(title, color = 'unknown')
    @id = generate_id
    @title = title
    @color = color
    @items = []
  end

  def add_item(item)
    @items << item unless @items.include?(item)
    item.label = self
  end

  def update_id(id)
    @id = id
  end

  def save_label_to_json(all_label)
    File.write('data/label.json', JSON.dump({
                                              data: all_label.map do |label|
                                                {
                                                  id: label.id,
                                                  title: label.title,
                                                  color: label.color
                                                }
                                              end
                                            }))
  end

  private

  def generate_id
    (rand * 1000).floor
  end
end
