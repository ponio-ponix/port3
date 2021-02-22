class AddUserIdToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :user_id, :integer
    add_column :categories, :is_active, :boolean, default: true
  end
end
