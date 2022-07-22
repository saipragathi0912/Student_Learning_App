class AddProgressToSubject < ActiveRecord::Migration[7.0]
  def change
    add_column :subjects, :progress, :float
  end
end
