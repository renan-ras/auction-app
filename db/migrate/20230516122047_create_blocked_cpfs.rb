class CreateBlockedCpfs < ActiveRecord::Migration[7.0]
  def change
    create_table :blocked_cpfs do |t|
      t.string :cpf
      t.text :reason

      t.timestamps
    end
  end
end
