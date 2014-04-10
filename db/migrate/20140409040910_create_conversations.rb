class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.integer :created_by
      t.integer :created_for

      t.timestamps
    end
  end
end
