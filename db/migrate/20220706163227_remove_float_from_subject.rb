class RemoveFloatFromSubject < ActiveRecord::Migration[7.0]
  def change
    remove_column :subjects, :float, :string
  end
end
