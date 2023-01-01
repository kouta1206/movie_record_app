class CreateStarrings < ActiveRecord::Migration[6.0]
  def change
    create_table :starrings do |t|
      t.string :name
      t.timestamps
    end
  end
end
