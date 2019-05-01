class CreateAttempts < ActiveRecord::Migration[5.2]
  def change
    create_table :attempts do |t|
      t.references :exam, foreign_key: true
      t.string :exam_token
      t.hstore :answers, :hstore, default: {}
      t.string :student_id, unique: true
      t.datetime :close_date, allow_blank: true
      t.float :grade, default: 0

      t.timestamps
    end
    add_index :attempts, :answers, using: :gin
  end
end
