class AddDefaultValueToHstores < ActiveRecord::Migration[5.2]
  def change
    change_column :answers, :variables, :hstore, default: {}
    change_column :exams, :random_questions, :hstore, default: {}
  end
end
