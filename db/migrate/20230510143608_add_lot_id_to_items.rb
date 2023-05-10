class AddLotIdToItems < ActiveRecord::Migration[7.0]
  def change
    add_reference :items, :lot, null: false, foreign_key: true
  end
end
