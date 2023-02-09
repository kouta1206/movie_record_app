class CreateMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :movies do |t|
      t.string :image_path
      t.string :title, index: true
      t.string :director
      t.string :release_at
      t.integer :evaluation
      t.string :viewing_at
      t.text :review
      t.references :user, foreign_key: true, index: true
      t.timestamps
    end
  end
end
