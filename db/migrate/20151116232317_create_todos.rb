class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :name
      t.references :list, index: true, foreign_key: true
      t.boolean :check

      t.timestamps null: false
    end
  end
end
