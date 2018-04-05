class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.string :schedule_type
      t.datetime :start_time
      t.bigint :schedule_father_id
      t.bigint :schedule_teaching_id
      t.string :custo

      t.timestamps null: false
    end
    add_index :schedules, :start_time
  end
end
