class CreateAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :answers do |t|
      t.references :attempt, null: false, foreign_key: true
      t.string :question
      t.string :references
      t.string :chosen_option
      t.boolean :review

      t.timestamps
    end
  end
end
