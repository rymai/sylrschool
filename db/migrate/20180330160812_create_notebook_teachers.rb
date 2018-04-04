class CreateNotebookTeachers < ActiveRecord::Migration
  def change
    create_table :notebook_teachers do |t|
      t.bigint :notebook_id
      t.bigint :teacher_id
      t.string :custo

      t.timestamps null: false
    end
    add_index :notebook_teachers, :notebook_id
    add_index :notebook_teachers, :teacher_id
  end
end
