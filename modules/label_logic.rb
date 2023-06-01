module LabelLogic
  def add_label
    print 'Enter book label (e.g Gift, New): '
    input_label = gets.chomp
    create_book_label(input_label)
  end

  def create_book_label(title)
    if @all_labels.empty?
      create_label_obj(title)
    else
      label_exist = @all_labels.find { |label| label.title == title }
      label_exist.nil? ? create_label_obj(title) : label_exist
    end
  end

  def create_label_obj(title)
    new_label = Label.new(title)
    @all_labels << new_label
    new_label.save_label_to_json(@all_labels)
    new_label
  end
end
