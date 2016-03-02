class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :name, :default => "Anon"
      t.text :content

      t.timestamps null: false
    end
  end
end
