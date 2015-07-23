class ChangeRatingForNewComments < ActiveRecord::Migration
  def change
    change_column :new_comments, :rating, :string, limit: 2
  end
end
