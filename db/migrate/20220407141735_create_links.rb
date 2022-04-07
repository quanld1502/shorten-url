class CreateLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :links do |t|
      t.string :url
      t.string :slug
      t.integer :clicked
      t.references :user, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end