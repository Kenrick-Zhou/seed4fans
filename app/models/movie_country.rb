class MovieCountry < ActiveRecord::Base
  belongs_to :movie
  belongs_to :country
end
