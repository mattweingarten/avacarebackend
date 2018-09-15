class CreateSymptoms < ActiveRecord::Migration[5.0]
  def change
    create_table :symptoms do |t|
      t.belongs_to :condition, index:true
      t.string :location
      t.integer :painlevel
      t.string :type1
      t.string :comment
      t.timestamps
    end
  end
end
