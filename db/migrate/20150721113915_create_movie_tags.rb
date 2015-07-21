class CreateMovieTags < ActiveRecord::Migration
  def change
    create_table :movie_tags do |t|
      t.integer :movie_id
      t.integer :tag_id
      t.string :name

      t.timestamps
    end
  end
end
