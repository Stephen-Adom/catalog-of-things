require 'json'
require_relative '../item'

class AuthorLogic
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
    File.open('authors.json', 'w') { |file| file.write(authors.to_json) }
    puts 'Authors saved successfully.'
  end

  def self.load_authors
    if File.exist?('authors.json')
      JSON.parse(File.read('authors.json'))
    else
      []
    end
  end

  def self.find_author(first_name, last_name)
    authors = load_authors
    author = authors.find { |a| a['first_name'] == first_name && a['last_name'] == last_name }
    author
  end

  def self.find_or_create_author
    authors = load_authors

    if authors.empty?
      puts 'No authors found. Please enter new author details.'
      create_new_author
    else
      puts 'Select an author from the list (enter the corresponding number) or enter 0 to enter a new author:'
      authors.each_with_index do |author, index|
        puts "#{index + 1}. #{author['first_name']} #{author['last_name']}"
      end

      print 'Your choice: '
      choice = gets.chomp.to_i

      if choice == 0
        create_new_author
      elsif choice >= 1 && choice <= authors.size
        author = authors[choice - 1]
        puts 'Author found.'
        author_object = Author.new(author['first_name'], author['last_name'])
        author_object.id = author['id']
        author_object
      else
        puts 'Invalid choice. Please try again.'
        find_or_create_author
      end
    end
  end

  def self.create_new_author
    print 'Enter Author First Name: '
    first_name = gets.chomp
    print 'Enter Author Last Name: '
    last_name = gets.chomp

    authors = load_authors
    existing_author = authors.find { |a| a['first_name'] == first_name && a['last_name'] == last_name }

    if existing_author.nil?
      author = Author.new(first_name, last_name)
      authors << serialize_author(author)
      save_authors(authors)
      puts 'Author created and saved successfully.'
      author
    else
      puts 'Author already exists.'
      author_object = Author.new(existing_author['first_name'], existing_author['last_name'])
      author_object.id = existing_author['id']
      author_object
    end
  end
end