class AddVariablesToQuestion < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :variables, :hstore, default: {}
    add_index :questions, :variables, using: :gin
    add_column :questions, :last_chosen_variables, :hstore, default: {}
    add_index :questions, :last_chosen_variables, using: :gin
  end
end
