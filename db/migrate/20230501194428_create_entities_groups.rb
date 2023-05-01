class CreateEntitiesGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :entities_groups, id: false do |t|
      t.integer :entity_id
      t.integer :group_id
    end
  end
end
