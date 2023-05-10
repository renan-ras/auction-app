class CreateLots < ActiveRecord::Migration[7.0]
  def change
    create_table :lots do |t|
      t.string :code
      t.datetime :start_date
      t.datetime :end_date
      t.decimal :minimum_bid
      t.decimal :minimum_bid_increment
      t.integer :status
      t.integer :creator_id
      t.integer :approver_id

      t.timestamps
    end
  end
end
