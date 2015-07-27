class ChangeSummaryForMovies < ActiveRecord::Migration
  def change
    change_column :movies, :summary, :string, limit: 1000
  end
end
