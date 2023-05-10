class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.string :image_url
      t.integer :weight
      t.integer :width
      t.integer :height
      t.integer :depth
      t.string :category
      t.string :code

      t.timestamps
    end
  end
end
