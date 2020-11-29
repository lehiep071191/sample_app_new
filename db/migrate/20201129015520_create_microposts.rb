class CreateMicroposts < ActiveRecord::Migration[6.0]
  def change
    create_table :microposts do |t|
      t.string :user_id, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
