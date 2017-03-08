class AddTagsToImages < ActiveRecord::Migration[5.0]
  def change
    add_column :images, :tags, :text, array: true, default: []
    add_index  :images, :tags, using: :gin
  end
end
