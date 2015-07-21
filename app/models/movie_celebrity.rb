class MovieCelebrity < ActiveRecord::Base
  belongs_to :movie
  belongs_to :celebrity
end
