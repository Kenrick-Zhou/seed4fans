class Duser < ActiveRecord::Base
  paginates_per 25
  max_paginates_per 200

end
