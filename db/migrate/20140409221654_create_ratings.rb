class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.references :rater, index: true
      t.references :ratee, index: true
      t.references :apprenticeship, index: true
      t.integer :rating

      t.timestamps
    end
  end
end
