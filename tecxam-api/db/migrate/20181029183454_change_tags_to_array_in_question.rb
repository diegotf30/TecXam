class ChangeTagsToArrayInQuestion < ActiveRecord::Migration[5.2]
  def change
    remove_column :questions, :tag
    add_column :questions, :tags, :text, default: [], array: true
  end
end
