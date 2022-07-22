class RemoveOptionFromAttempt < ActiveRecord::Migration[7.0]
  def change
    remove_column :attempts, :option, :string
    remove_column :attempts, :review, :boolean
  end
end
