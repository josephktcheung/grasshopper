class CreateApprenticeships < ActiveRecord::Migration
  def change
    create_table :apprenticeships do |t|
      t.datetime :end_date, :null => false
      t.references :master, index: true
      t.references :apprentice, index: true

      t.timestamps :null => false
    end
  end
end