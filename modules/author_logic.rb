require 'json'
require_relative '../classes/item'
require 'fileutils'

class AuthorLogic
  DATA_FOLDER = 'data'.freeze
  AUTHORS_FILE = File.join(DATA_FOLDER, 'authors.json').freeze

  def self.list_authors
    authors = load_authors
    puts 'List of Authors:'
    authors.each_with_index do |author, index|
      puts "#{index + 1}. ID: #{author['id']}, First Name: #{author['first_name']}, Last Name: #{author['last_name']}"
    end
  end

  def self.serialize_author(author)
    {
      id: author.id,
      first_name: author.first_name,
      last_name: author.last_name
    }
  end

  def self.save_authors(authors)
    File.write(AUTHORS_FILE, authors.to_json)
    puts 'Authors saved successfully.'
  end

  def self.load_authors
    return [] if File.empty?(AUTHORS_FILE)

    FileUtils.mkdir_p(DATA_FOLDER) unless File.directory?(DATA_FOLDER)
    if File.exist?(AUTHORS_FILE)
      JSON.parse(File.read(AUTHORS_FILE))
    else
      []
    end
  end

  def self.find_author(first_name, last_name)
    authors = load_authors
    authors.find { |a| a['first_name'] == first_name && a['last_name'] == last_name }
  end

  def self.find_or_create_author
    authors = load_authors

    if authors.empty?
      puts 'No authors found. Please enter new author details.'
      return create_new_author
    end

    display_author_list(authors)
    choice = get_user_choice(authors.size)

    if choice.zero?
      create_new_author
    elsif choice >= 1 && choice <= authors.size
      author = authors[choice - 1]
      puts 'Author found.'
      build_author_object(author)
    else
      puts 'Invalid choice. Please try again.'
      find_or_create_author
    end
  end

  def self.display_author_list(authors)
    puts 'Select an author from the list (enter the corresponding number) or enter 0 to enter a new author:'
    authors.each_with_index do |author, index|
      puts "#{index + 1}. #{author['first_name']} #{author['last_name']}"
    end
  end

  def self.get_user_choice(max_choice)
    print 'Your choice: '
    choice = gets.chomp.to_i
    return choice if choice.between?(0, max_choice)

    choice
  end

  def self.build_author_object(author)
    author_object = Author.new(author['first_name'], author['last_name'])
    author_object.id = author['id']
    author_object
  end

  def self.create_new_author
    print 'Enter Author First Name: '
    first_name = gets.chomp
    print 'Enter Author Last Name: '
    last_name = gets.chomp

    create_or_find_author(first_name, last_name)
  end

  def self.create_or_find_author(first_name, last_name)
    authors = load_authors
    existing_author = authors.find { |a| a['first_name'] == first_name && a['last_name'] == last_name }

    if existing_author.nil?
      author = Author.new(first_name, last_name)
      authors << serialize_author(author)
      save_authors(authors)
      puts 'Author created and saved successfully.'
      author
    else
      author_object = Author.new(existing_author['first_name'], existing_author['last_name'])
      author_object.id = existing_author['id']
      author_object
    end
  end

  def self.save_author_to_json(all_authors)
    File.write('data/authors.json', JSON.dump(
                                      all_authors.map do |author|
                                        {
                                          id: author.id,
                                          first_name: author.first_name,
                                          last_name: author.last_name
                                        }
                                      end
                                    ))
  end
end
