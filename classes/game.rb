require_relative 'item'
require 'json'

class Game < Item
  attr_accessor :multiplayer, :last_played_at

  def initialize(genre, author, source, label, publish_date, multiplayer, last_played_at)
    super(genre, author, source, label, publish_date)
    @multiplayer = multiplayer
    @last_played_at = last_played_at
  end

  def can_be_archived?
    super && last_played_more_than_two_years_ago?
  end

  private

  def last_played_more_than_two_years_ago?
    (Date.today - @last_played_at) > 365 * 2
  end
end