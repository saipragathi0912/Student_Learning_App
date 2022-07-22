class AddMobilenumberToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :mobilenumber, :string
  end
end
