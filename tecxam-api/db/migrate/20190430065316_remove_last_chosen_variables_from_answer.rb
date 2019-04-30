class RemoveLastChosenVariablesFromAnswer < ActiveRecord::Migration[5.2]
  def change
    remove_column :answers, :last_chosen_variables
  end
end
