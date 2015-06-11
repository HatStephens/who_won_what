class CreateGroupUserPairings < ActiveRecord::Migration
  def change
    create_table :group_user_pairings do |t|
      t.integer :group_user_one
      t.integer :group_user_two

      t.timestamps null: false
    end
  end
end
