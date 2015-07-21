class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.string :cn_title
      t.string :original_title
      t.float :rating
      t.string :poster_url
      t.string :poster_id
      t.string :subtype
      t.string :pubyear
      t.integer :duration
      t.string :imdb_id
      t.string :summary
      t.integer :e_count
      t.integer :e_duration

      t.timestamps
    end
  end
end
