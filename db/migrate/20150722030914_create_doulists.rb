class CreateDoulists < ActiveRecord::Migration
  def change
    create_table :doulists do |t|
      t.integer :movie_id
      t.string :name
      t.integer :dlist_id
      t.string :uname

      t.timestamps
    end
  end
end
