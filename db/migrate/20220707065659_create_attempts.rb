class CreateAttempts < ActiveRecord::Migration[7.0]
  def change
    create_table :attempts do |t|
      t.string :option
      t.boolean :review
      t.integer :number
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
