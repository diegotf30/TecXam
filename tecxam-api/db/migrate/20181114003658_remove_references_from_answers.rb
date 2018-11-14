class RemoveReferencesFromAnswers < ActiveRecord::Migration[5.2]
  def change
    remove_reference :answers, :question, foreign_key: true
  end
end
