class ChangeUserIdToBeIntegerInMicroposts < ActiveRecord::Migration[6.0]
  def change
  	change_column :microposts, :user_id, :integer
  end
end
