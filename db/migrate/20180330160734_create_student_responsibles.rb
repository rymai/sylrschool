class CreateStudentResponsibles < ActiveRecord::Migration
  def change
    create_table :student_responsibles do |t|
      t.bigint :student_id
      t.bigint :responsible_id
      t.string :custo

      t.timestamps null: false
    end
    add_index :student_responsibles, :student_id
    add_index :student_responsibles, :responsible_id
  end
end
