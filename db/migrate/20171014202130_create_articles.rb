class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.string :name
      t.text :excerpt
      t.text :body
      t.datetime :published_at
      t.references :user, foreign_key: true
      t.string :permalink
      t.boolean :anonymous

      t.timestamps
    end
  end
end
