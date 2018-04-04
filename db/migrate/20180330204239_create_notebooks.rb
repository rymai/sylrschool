class CreateNotebooks < ActiveRecord::Migration
  def change
    create_table :notebooks do |t|
      t.string :name
      t.text :notebooktext
      t.bigint :student_id
      t.text :description
      t.string :custo

      t.timestamps null: false
    end
    add_index :notebooks, :name
    add_index :notebooks, :student_id
  end
end
