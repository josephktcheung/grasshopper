class AddIsActiveToApprenticeships < ActiveRecord::Migration
  def change
    add_column :apprenticeships, :is_active, :boolean
  end
end
