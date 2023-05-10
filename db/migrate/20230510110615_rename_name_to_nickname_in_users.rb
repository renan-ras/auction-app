class RenameNameToNicknameInUsers < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :name, :nickname
    add_index :users, :nickname, unique: true
  end
end
