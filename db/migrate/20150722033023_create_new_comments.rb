class CreateNewComments < ActiveRecord::Migration
  def change
    create_table :new_comments do |t|
      t.integer :movie_id
      t.string :did
      t.string :name
      t.integer :rating
      t.string :pubdate
      t.string :comment

      t.timestamps
    end
  end
end
