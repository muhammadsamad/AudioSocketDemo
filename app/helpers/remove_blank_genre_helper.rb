module RemoveBlankGenreHelper
  def remove_blank_genre
    genre.reject!(&:blank?)
  end
end
