class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :from_user
      t.integer :to_user

      t.timestamps
    end
  end
end
