class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.references :lot, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :content, null: false
      t.text :answer
      t.references :answered_by, foreign_key: { to_table: :users }
      t.boolean :hidden, default: false

      t.timestamps
    end
  end
end
