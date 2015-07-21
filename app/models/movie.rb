class Movie < ActiveRecord::Base
  has_many :akas

  has_many :movie_celebrities
  has_many :celebrities, :through => :movie_celebrities


end
