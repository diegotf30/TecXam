class AddRandomQuestionsToExams < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'hstore'
    remove_column :exams, :is_random
    add_column :exams, :random_questions, :hstore
    add_index :exams, :random_questions, using: :gin
  end
end
