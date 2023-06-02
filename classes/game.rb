require_relative 'item'
require 'json'

class Game < Item
  attr_accessor :multiplayer, :last_played_at

  def initialize(genre, author, label, publish_date, options = {})
    super(genre, author, label, publish_date)
    @multiplayer = options[:multiplayer]
    @last_played_at = options[:last_played_at]
  end

  def can_be_archived?
    super && last_played_more_than_two_years_ago?
  end

  private

  def last_played_more_than_two_years_ago?
    today = Date.today
    two_years_ago = Date.new(today.year - 2, today.month, today.day)

    two_years_ago >= Date.parse(@last_played_at)
  end
end
