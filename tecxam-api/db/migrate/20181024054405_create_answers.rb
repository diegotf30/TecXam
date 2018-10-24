class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.string :name
      t.text :variables, array: true, default: []
      t.references :question, foreign_key: true

      t.timestamps
    end
  end
end
