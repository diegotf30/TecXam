class RemoveForeignKeyFromAnswers < ActiveRecord::Migration[5.2]
  def change
    remove_reference :answers, :question, foreign_key: true
    add_reference :answers, :question
  end
end
