class Movie < ActiveRecord::Base
  paginates_per 25
  max_paginates_per 200

  has_many :akas

  has_many :movie_celebrities
  has_many :celebrities, :through => :movie_celebrities

  has_many :movie_types
  has_many :types, :through => :movie_types

  has_many :movie_countries
  has_many :countries, :through => :movie_countries

  has_many :movie_languages
  has_many :languages, :through => :movie_languages

  has_many :movie_tags
  has_many :tags, :through => :movie_tags

  has_many :photos

  has_many :awards

  has_many :recommendations

  has_many :doulist

  has_many :hot_comments
  has_many :new_comments
end
