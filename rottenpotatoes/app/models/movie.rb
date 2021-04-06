class Movie < ActiveRecord::Base
  def movies_by_director
    Hash[:director, self.director, :movies, Movie.where(:director => self.director)]
  end
end
