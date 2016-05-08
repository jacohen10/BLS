class CreateEmployments < ActiveRecord::Migration
  def change
    create_table :employments do |t|
      t.integer :value

      t.timestamps null: false
    end
  end
end
