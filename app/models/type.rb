class Type < ActiveRecord::Base
  has_many :movie_types
  has_many :movies, :through => :movie_types
end
