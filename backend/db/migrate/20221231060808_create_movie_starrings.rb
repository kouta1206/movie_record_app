class CreateMovieStarrings < ActiveRecord::Migration[6.0]
  def change
    create_table :movie_starrings do |t|
      t.references :movie, foreign_key: true, index: true, null: false
      t.references :starring, foreign_key: true, index: true, null: false
      t.timestamps
    end
  end
end
