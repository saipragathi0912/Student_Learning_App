class AddProfilephotoToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :profilephoto, :string
  end
end
