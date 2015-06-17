class AddDidToDusers < ActiveRecord::Migration
  def change
    add_column :dusers, :did, :string
  end
end
