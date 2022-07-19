class CreateResidents < ActiveRecord::Migration[6.1]
  def change
    create_table :residents do |t|
      t.string :full_name, default: '', null: false
      t.string :document, default: '', null: false
      t.string :health_card_document, default: '', null: false
      t.string :email, default: '', null: false
      t.datetime :birthdate, null: false
      t.string :phone, default: '', null: false
      t.integer :status, default: 1, null: false

      t.timestamps
    end
    add_index :residents, :full_name
    add_index :residents, :document
    add_index :residents, :health_card_document
    add_index :residents, :email
    add_index :residents, :phone
  end
end
