class CreateMatchPlayers < ActiveRecord::Migration
  def change
    create_table :match_players do |t|
      t.references :match, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :match_players, :matches
    add_foreign_key :match_players, :users
  end
end
