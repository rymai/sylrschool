class CreateTeachings < ActiveRecord::Migration
  def change
    create_table :teachings do |t|
      t.string :name
      t.bigint :teaching_class_school_id
      t.bigint :teaching_teacher_id
      t.bigint :teaching_matter_id
      t.string :teaching_domain_id
      t.datetime :teaching_start_time
      t.string :teaching_repetition
      t.integer :teaching_repetition_number
      t.integer :teaching_duration
      t.text :description
      t.string :custo

      t.timestamps null: false
    end
    add_index :teachings, :name
    add_index :teachings, :teaching_class_school_id
    add_index :teachings, :teaching_teacher_id
    add_index :teachings, :teaching_matter_id
  end
end
