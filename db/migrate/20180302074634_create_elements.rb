class CreateElements < ActiveRecord::Migration
  def change
    create_table :elements do |t|
      t.string :name
      t.string :for_what
      t.text :description
      t.string :custo

      t.timestamps null: false
    end
    add_index :elements, :name
    add_index :elements, :for_what
  end
end
