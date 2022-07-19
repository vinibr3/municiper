class ChangeResidentStatusToInteger < ActiveRecord::Migration[6.1]
  def change
    change_column :residents, :status, :integer, default: 1, null: false
  end
end
