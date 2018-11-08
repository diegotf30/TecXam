class ChangeVarsInAnswers < ActiveRecord::Migration[5.2]
  def change
    remove_column :answers, :variables
    add_column :answers, :variables, :hstore
    add_index :answers, :variables, using: :gin
  end
end
