class CreateGrades < ActiveRecord::Migration
  def change
    create_table :grades do |t|
      t.bigint :grade_grade_context_id
      t.bigint :grade_matter_id
      t.bigint :grade_student_id
      t.date :grade_date
      t.string :value
      t.text :description
      t.string :custo

      t.timestamps null: false
    end
    add_index :grades, :grade_grade_context_id
    add_index :grades, :grade_matter_id
    add_index :grades, :grade_student_id
  end
end
