class CreateRegistrants < ActiveRecord::Migration
  def change
    create_table :registrants do |t|
      t.string :email
      t.string :registration_code
      t.datetime :registration_expires_at
    end
  end
end
