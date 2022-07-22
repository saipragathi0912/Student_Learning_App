class RemoveProgressFromSubject < ActiveRecord::Migration[7.0]
  def change
    remove_column :subjects, :progress, :string
  end
end
