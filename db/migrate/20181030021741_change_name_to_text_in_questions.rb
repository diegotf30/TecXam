class ChangeNameToTextInQuestions < ActiveRecord::Migration[5.2]
  def change
    change_column :questions, :name, :text
  end
end
