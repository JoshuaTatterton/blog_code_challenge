class AddBloggerIdToSubscribers < ActiveRecord::Migration
  def change
    add_reference :subscribers, :blogger, index: true, foreign_key: true
  end
end
