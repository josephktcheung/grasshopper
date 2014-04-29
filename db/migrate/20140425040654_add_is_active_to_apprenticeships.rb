class AddStatusToApprenticeships < ActiveRecord::Migration
  def change
    add_column :apprenticeships, :status, :string
  end
end
