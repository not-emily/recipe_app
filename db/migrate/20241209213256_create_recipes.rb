class CreateRecipes < ActiveRecord::Migration[7.1]
  def change
    create_table :recipes do |t|
      t.integer         :user_id
      t.decimal         :deposit, precision: 15, scale: 2
      t.decimal         :balance, precision: 15, scale: 2
      t.string          :apikey
      t.string          :status


      t.timestamps
      t.index :apikey
    end
  end
end
