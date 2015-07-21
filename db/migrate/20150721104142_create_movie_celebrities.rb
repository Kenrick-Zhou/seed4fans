class CreateMovieCelebrities < ActiveRecord::Migration
  def change
    create_table :movie_celebrities do |t|
      t.integer :movie_id
      t.integer :celebrity_id
      t.string :name
      t.string :role

      t.timestamps
    end
  end
end
