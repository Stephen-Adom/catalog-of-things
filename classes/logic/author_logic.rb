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
end
