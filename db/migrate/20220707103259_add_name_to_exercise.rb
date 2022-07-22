class AddNameToExercise < ActiveRecord::Migration[7.0]
  def change
    add_column :exercises, :name, :string
  end
end
