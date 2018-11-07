class AddDescriptorsToExam < ActiveRecord::Migration[5.2]
  def change
    change_table :exams do |t|
      t.text :description, default: ""
      t.string :date, default: ""
      t.integer :time_limit, default: 90
    end
  end
end
