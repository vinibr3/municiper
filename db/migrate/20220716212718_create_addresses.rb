class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.string :zipcode, default: '', null: false
      t.string :street, default: '', null: false
      t.string :complement, default: ''
      t.string :neighboorhood, default: '', null: false
      t.string :city, default: '', null: false
      t.string :state, default: '', null: false
      t.string :ibge_code, default: ''
      t.references :addressable, polymorphic: true

      t.timestamps
    end
    add_index :addresses, :zipcode
    add_index :addresses, :street
    add_index :addresses, :neighboorhood
    add_index :addresses, :city
    add_index :addresses, :state
    add_index :addresses, :ibge_code
  end
end
