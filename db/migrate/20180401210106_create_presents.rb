class CreatePresents < ActiveRecord::Migration
  def change
    create_table :presents do |t|
      t.bigint :student_id
      t.bigint :schedule_id
      t.bigint :teaching_id
      t.string :present_type
      t.text :description
      t.string :custo

      t.timestamps null: false
    end
    add_index :presents, :student_id
    add_index :presents, :schedule_id
    add_index :presents, :teaching_id
  end
end
