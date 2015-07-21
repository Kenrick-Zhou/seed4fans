class Celebrity < ActiveRecord::Base
  has_many :movie_celebrities
  has_many :movies, :through => :movie_celebrities
end
