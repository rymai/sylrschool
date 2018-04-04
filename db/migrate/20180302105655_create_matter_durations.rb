class CreateMatterDurations < ActiveRecord::Migration
  def change
    create_table :matter_durations do |t|
      t.string :name
      t.bigint :matter_duration_level_id
      t.integer :value
      t.text :description
      t.string :custo
      t.timestamps null: false
    end
    add_index :matter_durations, :name
  end
end
