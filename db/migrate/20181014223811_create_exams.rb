class CreateExams < ActiveRecord::Migration[5.2]
  def change
    create_table :exams do |t|
      t.string :name
      t.boolean :is_random

      t.timestamps
    end

    add_reference :exams, :user, foreign_key: true
  end
end
