require_relative '../item'
require 'json'

class GameLogic
  def self.list_games
    games = load_games
    puts 'List of Games:'
    games.each_with_index do |game, index|
      puts "#{index + 1}. ID: #{game['id']}, Archived: #{game['archived']}, Genre: #{game['genre']}, Author: #{game['author']}, Source: #{game['source']}, Label: #{game['label']}, Publish Date: #{game['publish_date']}, Multiplayer: #{game['multiplayer']}, Last Played At: #{game['last_played_at']}"
    end
  end

  def self.add_game
    puts 'Enter game details:'
    print 'Genre: '
    genre = gets.chomp
    author = find_or_create_author
    print 'Source: '
    source = gets.chomp
    print 'Label: '
    label = gets.chomp
    print 'Publish date (YYYY-MM-DD): '
    publish_date = gets.chomp
    print 'Multiplayer (true/false): '
    multiplayer = gets.chomp.downcase == 'true'
    print 'Last played at (YYYY-MM-DD): '
    last_played_at = gets.chomp
  
    game = Game.new(genre, author, source, label, publish_date, multiplayer, Date.parse(last_played_at))
    save_game(game)
  end
  
  def self.find_author(first_name, last_name)
    authors = AuthorLogic.load_authors
    author = authors.find { |a| a['first_name'] == first_name && a['last_name'] == last_name }
    author
  end  

  def self.find_or_create_author
    authors = AuthorLogic.load_authors
  
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
  
    authors = AuthorLogic.load_authors
    existing_author = authors.find { |a| a['first_name'] == first_name && a['last_name'] == last_name }
  
    if existing_author.nil?
      author = Author.new(first_name, last_name)
      authors << AuthorLogic.serialize_author(author)
      AuthorLogic.save_authors(authors)
      puts 'Author created and saved successfully.'
      author
    else
      puts 'Author already exists.'
      author_object = Author.new(existing_author['first_name'], existing_author['last_name'])
      author_object.id = existing_author['id']
      author_object
    end
  end   

  def self.save_game(game)
    games = load_games
    games << serialize_game(game)
    File.open('games.json', 'w') { |file| file.write(JSON.generate(games)) }
    puts 'Game saved successfully.'
  end

  private

  def self.serialize_game(game)
    {
      id: game.id,
      archived: game.archived,
      genre: game.genre,
      author: "#{game.author.first_name} #{game.author.last_name}",
      source: game.source,
      label: game.label,
      publish_date: game.publish_date.to_s,
      multiplayer: game.multiplayer,
      last_played_at: game.last_played_at.to_s
    }
  end

  def self.load_games
    if File.exist?('games.json')
      games_data = File.read('games.json')
      games_data.empty? ? [] : JSON.parse(games_data)
    else
      []
    end
  end
end
