class AddDefaultValueToStatusInLots < ActiveRecord::Migration[7.0]
  def change
    change_column_default :lots, :status, 1
  end
end
