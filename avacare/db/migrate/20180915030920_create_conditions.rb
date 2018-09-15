class CreateConditions < ActiveRecord::Migration[5.0]
  def change
    create_table :conditions do |t|
      t.belongs_to :user, index:true
      t.boolean :accident
      t.float :fever
      t.timestamps
    end
  end
end
