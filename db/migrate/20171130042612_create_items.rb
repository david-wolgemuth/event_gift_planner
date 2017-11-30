class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :title
      t.string :image_url
      t.string :listing_url
      t.decimal :price
      t.text :notes

      t.timestamps
    end
  end
end
