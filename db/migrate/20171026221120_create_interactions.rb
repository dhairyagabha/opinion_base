class CreateInteractions < ActiveRecord::Migration[5.1]
  def change
    create_table :interactions do |t|
      t.string :interaction
      t.references :entity, polymorphic: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
