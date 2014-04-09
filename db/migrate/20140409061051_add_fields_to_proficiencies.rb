class AddFieldsToProficiencies < ActiveRecord::Migration
  def change
    add_column :proficiencies, :proficiency_status, :string
  end
end
