class CreateMovieCountries < ActiveRecord::Migration
  def change
    create_table :movie_countries do |t|
      t.integer :movie_id
      t.integer :country_id
      t.string :name

      t.timestamps
    end
  end
end
