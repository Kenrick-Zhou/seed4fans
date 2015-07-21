class CreateMovieTypes < ActiveRecord::Migration
  def change
    create_table :movie_types do |t|
      t.integer :movie_id
      t.integer :type_id
      t.string :name

      t.timestamps
    end
  end
end
