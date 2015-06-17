class AddCReviewToDusers < ActiveRecord::Migration
  def change
    add_column :dusers, :c_review, :integer
  end
end
