class CreateMatters < ActiveRecord::Migration
  def change
    create_table :matters do |t|
      t.string :name
      t.integer :matter_type_id
      t.integer :matter_duration_id
      t.integer :matter_nb_max_student
      t.text :description
      t.string :custo

      t.timestamps null: false
    end
    add_index :matters, :name
  end
end
