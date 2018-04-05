class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.string :usage_id
      t.text :description
      t.integer :location_nb_max_person
      t.string :custo

      t.timestamps null: false
    end
    add_index :locations, :name
  end
end
