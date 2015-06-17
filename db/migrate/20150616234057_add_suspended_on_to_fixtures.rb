class AddSuspendedOnToFixtures < ActiveRecord::Migration
  def change
    add_column :fixtures, :suspended_on, :date
  end
end
