class CreateMovieGenres < ActiveRecord::Migration[6.0]
  def change
    create_table :movie_genres do |t|
      t.references :movie, index: true, foreign_key: true, null: false
      t.references :genre, index: true, foreign_key: true, null: false
      t.timestamps
    end
  end
end
