class AddExerciseToAttempt < ActiveRecord::Migration[7.0]
  def change
    add_reference :attempts, :exercise, null: true, foreign_key: true
  end
end
