class CreateItemsReceivers < ActiveRecord::Migration[5.1]
  def change
    create_table :items_receivers do |t|
      t.references :item, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
