class CreateChaptersummaries < ActiveRecord::Migration[7.0]
  def change
    create_table :chaptersummaries do |t|
      t.string :name
      t.integer :numofexercises
      t.float :progress

      t.timestamps
    end
  end
end
