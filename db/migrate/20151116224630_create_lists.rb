class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :title
      t.string :share_code
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
