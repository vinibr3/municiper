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
  end
end
