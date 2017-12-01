class CreateManagements < ActiveRecord::Migration[5.1]
  def change
    create_table :managements do |t|
      t.references :manager
      t.references :managed_user

      t.timestamps
    end
    add_foreign_key :managements, :users, column: :manager_id
    add_foreign_key :managements, :users, column: :managed_user_id
  end
end
