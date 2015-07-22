class CreateRecommendations < ActiveRecord::Migration
  def change
    create_table :recommendations do |t|
      t.integer :movie_id
      t.integer :rcmd_id
      t.string :rcmd_name
      t.string :rcmd_poster_id
      t.string :rcmd_poster_cdn

      t.timestamps
    end
  end
end
