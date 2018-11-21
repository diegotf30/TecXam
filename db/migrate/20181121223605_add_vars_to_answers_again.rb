class AddVarsToAnswersAgain < ActiveRecord::Migration[5.2]
  def change
    add_column :answers, :variables, :hstore, default: {}
    add_index :answers, :variables, using: :gin
    add_column :answers, :last_chosen_variables, :hstore, default: {}
    add_index :answers, :last_chosen_variables, using: :gin
  end
end
