class CreateFixtureGroupUsers < ActiveRecord::Migration
  def change
    create_table :fixture_group_users do |t|
      t.references :fixture, index: true
      t.references :group_user, index: true

      t.timestamps null: false
    end
    add_foreign_key :fixture_group_users, :fixtures
    add_foreign_key :fixture_group_users, :group_users
  end
end
