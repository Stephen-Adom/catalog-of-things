require_relative 'app'
require_relative './classes/game'
require_relative './classes/author'

def main
  app = App.new
  app.run
end

main