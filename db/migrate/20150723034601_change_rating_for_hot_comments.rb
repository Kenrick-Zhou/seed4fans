class ChangeRatingForHotComments < ActiveRecord::Migration
  def change
    change_column :hot_comments, :rating, :string, limit: 2
  end
end
