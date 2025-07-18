class ChangeBoxIdNullableInItems < ActiveRecord::Migration[7.1]
  def change
    change_column_null :items, :box_id, true
  end
end
