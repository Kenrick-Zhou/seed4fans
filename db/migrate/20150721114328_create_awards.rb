class CreateAwards < ActiveRecord::Migration
  def change
    create_table :awards do |t|
      t.integer :movie_id
      t.string :name
      t.string :sub

      t.timestamps
    end
  end
end
