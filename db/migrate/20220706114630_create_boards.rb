class CreateBoards < ActiveRecord::Migration[7.0]
  def change
    create_table :boards do |t|
      t.string :name
      t.string :logo
      t.integer :boardid
      t.string :color

      t.timestamps
    end
  end
end
