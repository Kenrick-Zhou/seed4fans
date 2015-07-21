class CreateAkas < ActiveRecord::Migration
  def change
    create_table :akas do |t|
      t.integer :movie_id
      t.string :aka

      t.timestamps
    end
  end
end
