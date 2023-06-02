require_relative './item'

class MusicAlbum < Item
  attr_accessor :on_spotify

  def initialize(genre, author, label, on_spotify, publish_date)
    super(genre, author, label, publish_date)
    @on_spotify = on_spotify
  end

  # should return true if parent's method returns true AND if on_spotify equals true
  # otherwise, it should return false
  private

  def can_be_archived?
    super && @on_spotify
  end
end
