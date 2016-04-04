class AddUsernameToBlogger < ActiveRecord::Migration
  def change
    add_column :bloggers, :username, :string
  end
end
