class AddDobToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :dob, :string
  end
end
