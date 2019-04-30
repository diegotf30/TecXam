class AddVariablesToAnswers < ActiveRecord::Migration[5.2]
  def change
    add_column :answers, :variables, :hstore, default: {}
    add_index :answers, :variables, using: :gin
  end
end
