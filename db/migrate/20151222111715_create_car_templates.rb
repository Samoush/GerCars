class CreateCarTemplates < ActiveRecord::Migration
  def change
    create_table :car_templates do |t|
      t.string :brand
      t.string :model
      t.string :general_chassi

      t.timestamps null: false
    end
  end
end
