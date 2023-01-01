class CreateMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :movies do |t|
      t.string :image_path
      t.string :title
      t.string :director
      t.date :release
      t.integer :evaluation
      t.date :viewing
      t.text :review
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
