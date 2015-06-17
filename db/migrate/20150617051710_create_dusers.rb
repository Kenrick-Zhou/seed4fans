class CreateDusers < ActiveRecord::Migration
  def change
    create_table :dusers do |t|
      t.string :uid
      t.string :name
      t.integer :c_follower
      t.integer :c_m_do
      t.integer :c_m_wish
      t.integer :c_m_collect
      t.integer :c_doulist
      t.string :error

      t.timestamps
    end
  end
end
