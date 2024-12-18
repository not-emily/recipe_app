class CreateCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :categories do |t|
      t.integer          :user_id
      t.string          :category_name

      t.string          :apikey
      t.string          :status

      t.timestamps
      t.index :apikey
    end
  end
end
