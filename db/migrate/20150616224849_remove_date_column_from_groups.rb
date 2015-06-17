class RemoveDateColumnFromGroups < ActiveRecord::Migration
  def change
    remove_column :groups, :date, :string
  end
end
