class AddTypeToQuestion < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :category, :string, default: "multiple_choice", allow_null: false
  end
end
