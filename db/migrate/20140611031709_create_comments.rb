class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :title
      t.text :body, null: false

      t.timestamps
    end
  end
end
