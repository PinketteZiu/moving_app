class CreateBoxes < ActiveRecord::Migration[7.1]
  def change
    create_table :boxes do |t|
      t.string :number, null: false
      t.text :description
      t.string :destination_room
      t.references :room, null: false, foreign_key: true

      t.timestamps
    end

    add_index :boxes, :number, unique: true

  end
end
