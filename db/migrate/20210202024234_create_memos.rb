class CreateMemos < ActiveRecord::Migration[5.2]
  def change
    create_table :memos do |t|
      t.integer :user_id
      t.integer :parent_id
      t.integer :category_id
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
