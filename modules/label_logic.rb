require_relative '../app'

class LabelLogic
  def initialize
    @all_local_labels = load_labels
  end

  def add_label
    print 'Enter label title (e.g Gift, New): '
    input_label = gets.chomp

    print 'Enter label color (e.g red, blue): '
    input_color = gets.chomp
    create_book_label(input_label, input_color)
  end

  def create_book_label(title, color = 'unknown')
    if @all_local_labels.empty?
      create_label_obj(title, color)
    else
      label_exist = @all_local_labels.find { |label| label.title == title }
      label_exist.nil? ? create_label_obj(title, color) : label_exist
    end
  end

  def create_label_obj(title, color)
    new_label = Label.new(title, color)
    @all_local_labels << new_label
    App.new.all_labels << new_label
    new_label.save_label_to_json(@all_local_labels)
    new_label
  end

  def load_labels
    all_labels = []
    return all_labels unless File.exist?('./data/label.json')

    return all_labels if File.empty?('./data/books.json')

    File.open('./data/label.json', 'r') do |file|
      label_data = JSON.parse(file.read)['data']
      label_data.map do |data|
        label_obj = Label.new(data['title'], data['color'])

        label_obj.update_id(data['id'])

        all_labels << label_obj
      end
    end

    all_labels
  end
end
