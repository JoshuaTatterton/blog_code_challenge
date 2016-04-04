class AddSlugToBloggers < ActiveRecord::Migration
  def change
    add_column :bloggers, :slug, :string
    add_index :bloggers, :slug, unique: true
  end
end
