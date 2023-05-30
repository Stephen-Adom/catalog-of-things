require 'json'
require_relative '../item'

class AuthorLogic
  def self.list_authors
    authors = load_authors
    authors.each { |author| puts author }
  end

  def self.save_authors(authors)
    File.open('authors.json', 'w') { |file| file.write(authors.to_json) }
    puts 'Authors saved successfully.'
  end

  private

  def self.load_authors
    if File.exist?('authors.json')
      JSON.parse(File.read('authors.json'))
    else
      []
    end
  end
end
