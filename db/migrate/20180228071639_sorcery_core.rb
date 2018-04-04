class SorceryCore < ActiveRecord::Migration
    def change
        create_table :users do |t|
            t.string :name
            t.string :email,              null: false, default: ""
            t.string :crypted_password
            t.string :salt
            t.string :description
            t.string :custo
            t.string :role
            t.timestamps :null => false
        end

    end
end
