class AddCloseDateToExam < ActiveRecord::Migration[5.2]
  def change
    remove_column :attempts, :close_date
    add_column :exams, :close_date, :date
  end
end
