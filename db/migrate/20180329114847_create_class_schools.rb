class CreateClassSchools < ActiveRecord::Migration
  def change
    create_table :class_schools do |t|
      t.string :name
      t.integer :nb_max_student
      t.text :description
      t.string :custo

      t.timestamps null: false
    end
    add_index :class_schools, :name
  end
end
