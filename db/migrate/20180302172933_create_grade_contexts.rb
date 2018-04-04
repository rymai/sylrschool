class CreateGradeContexts < ActiveRecord::Migration
  def change
    create_table :grade_contexts do |t|
      t.string :name
      t.string :goal
      t.string :min_value
      t.string :max_value
      t.text :description
      t.string :custo

      t.timestamps null: false
    end
    add_index :grade_contexts, :name
  end
end
