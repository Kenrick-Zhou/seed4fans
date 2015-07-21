class Movie < ActiveRecord::Base
  has_many :akas

  has_many :movie_celebrities
  has_many :celebrities, :through => :movie_celebrities

  has_many :movie_types
  has_many :types, :through => :movie_types

  has_many :movie_countries
  has_many :countries, :through => :movie_countries

end
