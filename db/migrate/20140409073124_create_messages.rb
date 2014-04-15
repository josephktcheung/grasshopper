class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :recipient, index: true
      t.references :sender, index: true
      t.references :conversation, index: true
      t.text :content

      t.timestamps
    end
  end
end
