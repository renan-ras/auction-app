class CreateBids < ActiveRecord::Migration[7.0]
  def change
    create_table :bids do |t|
      t.decimal :amount, null: false, precision: 10, scale: 2
      t.references :user, null: false, foreign_key: true
      t.references :lot, null: false, foreign_key: true

      t.timestamps
    end
  end
end
