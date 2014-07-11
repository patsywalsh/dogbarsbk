class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :name
      t.string :description
      t.string :neighborhood
      t.integer :rating

      t.timestamps
    end
  end
end
