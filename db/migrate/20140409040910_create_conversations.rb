class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.references :created_by, index: true
      t.references :created_for, index: true

      t.timestamps
    end
  end
end
