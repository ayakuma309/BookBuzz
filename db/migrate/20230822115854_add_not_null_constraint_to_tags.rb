class AddNotNullConstraintToTags < ActiveRecord::Migration[7.0]
  def change
    change_column :tags, :name, :string, null: false
  end
end
