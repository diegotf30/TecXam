class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.string :name
      t.text :variables, array: true, default: []

      t.timestamps
    end

    add_reference :answers, :question, foreign_key: true
  end
end
