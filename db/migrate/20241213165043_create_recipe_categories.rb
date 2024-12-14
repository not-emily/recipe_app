class CreateRecipeCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :recipe_categories do |t|
      t.integer           :recipe_id
      t.integer           :category_id

      t.string            :apikey
      t.string            :status

      t.timestamps
      t.index :apikey
    end
  end
end
