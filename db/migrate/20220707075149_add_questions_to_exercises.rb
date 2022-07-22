class AddQuestionsToExercises < ActiveRecord::Migration[7.0]
  def change
    add_column :exercises, :questions, :integer
  end
end
