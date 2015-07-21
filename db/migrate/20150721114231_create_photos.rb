class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :movie_id
      t.string :pid
      t.string :cdn

      t.timestamps
    end
  end
end
