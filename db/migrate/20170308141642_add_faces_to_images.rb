class AddFacesToImages < ActiveRecord::Migration[5.0]
  def change
    add_column :images, :faces, :json, default: {}
  end
end
