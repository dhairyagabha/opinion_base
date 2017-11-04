class AddViewsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :views, :integer, default: 0
  end
end
