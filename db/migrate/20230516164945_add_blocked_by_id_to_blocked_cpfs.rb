class AddBlockedByIdToBlockedCpfs < ActiveRecord::Migration[7.0]
  def change
    add_reference :blocked_cpfs, :blocked_by, null: false, foreign_key: { to_table: :users }
  end
end
