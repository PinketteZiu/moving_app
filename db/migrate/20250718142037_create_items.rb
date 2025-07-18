class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.text :description
      t.decimal :value, precision: 10, scale: 2, default: 0
      t.string :condition, default: 'good'
      t.references :room, null: false, foreign_key: true
      t.references :box, null: false, foreign_key: true

      t.timestamps
    end

    add_index :items, :name
    add_index :items, :condition

  end
end
