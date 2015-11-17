class AddTokenToLists < ActiveRecord::Migration
  def change
    add_column :lists, :token, :string
  end
end
