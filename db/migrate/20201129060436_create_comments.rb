class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.integer :user_id, foreign_key: true
      t.integer :micropost_id, foreign_key: true
      t.string :content

      t.timestamps
    end
  end
end
