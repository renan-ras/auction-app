class ChangeLotIdInItems < ActiveRecord::Migration[7.0]
  def change
    change_column_null :items, :lot_id, true
  end
end
