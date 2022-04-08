class CreateLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :links do |t|
      t.string :url
      t.string :slug
      t.integer :clicked, default: 0, null: false
      t.references :user, null: false, foreign_key: true, index: true

      t.timestamps
    end

    add_index :links, :slug, unique: true
    add_index :links, [:user_id, :slug]
  end
end
