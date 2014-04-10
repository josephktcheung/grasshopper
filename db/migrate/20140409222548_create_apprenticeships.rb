class CreateApprenticeships < ActiveRecord::Migration
  def change
    create_table :apprenticeships do |t|
      t.datetime :end_date
      t.references :master, index: true
      t.references :apprentice, index: true

      t.timestamps
    end
  end
end
