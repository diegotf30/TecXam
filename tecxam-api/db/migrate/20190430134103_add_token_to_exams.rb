class AddTokenToExams < ActiveRecord::Migration[5.2]
  def change
    add_column :exams, :token, :string
  end
end
