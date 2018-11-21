class AddParsedNameToAnswer < ActiveRecord::Migration[5.2]
  def change
    add_column :answers, :parsed_name, :string, default: ""
  end
end
