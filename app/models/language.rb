class Language < ActiveRecord::Base
  paginates_per 25
  max_paginates_per 200

  has_many :movie_languages
  has_many :movies, :through => :movie_languages
end
