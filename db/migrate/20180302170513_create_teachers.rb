class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.string :name
      t.string :person_status
      t.string :email
      t.string :firstname
      t.string :lastname
      t.string :adress
      t.string :postalcode
      t.string :town
      t.string :phone1
      t.string :phone2
      t.date :birthday
      t.text :description
      t.string :custo
      t.integer :defmatter_id
      t.integer :defgradecontext_id

      t.timestamps null: false
    end
    add_index :students, :name
    add_index :students, :email
  end
end
