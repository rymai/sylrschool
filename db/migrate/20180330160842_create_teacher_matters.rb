class CreateTeacherMatters < ActiveRecord::Migration
  def change
    create_table :teacher_matters do |t|
      t.bigint :teacher_id
      t.bigint :matter_id
      t.string :custo

      t.timestamps null: false
    end
    add_index :teacher_matters, :teacher_id
    add_index :teacher_matters, :matter_id
  end
end
