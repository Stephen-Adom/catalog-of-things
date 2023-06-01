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
    (Date.today - @last_played_at).to_i  > 365 * 2
  end
end
