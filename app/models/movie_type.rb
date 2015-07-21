class MovieType < ActiveRecord::Base
  belongs_to :movie
  belongs_to :type
end
