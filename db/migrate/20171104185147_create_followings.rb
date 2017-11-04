class CreateFollowings < ActiveRecord::Migration[5.1]
  def change
    create_table :followings do |t|
      t.references :user, foreign_key: true
      t.references :follow, polymorphic: true

      t.timestamps
    end
  end
end
