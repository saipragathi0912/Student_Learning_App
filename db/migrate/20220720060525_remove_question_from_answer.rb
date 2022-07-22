class RemoveQuestionFromAnswer < ActiveRecord::Migration[7.0]
  def change
    remove_column :answers, :question, :string
    remove_column :answers, :references, :string
  end
end
