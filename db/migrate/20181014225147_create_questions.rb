class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.string :name

      t.timestamps
    end

    add_reference :questions, :user, foreign_key: true
  end
end
