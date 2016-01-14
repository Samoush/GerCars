class CreateOrderCars < ActiveRecord::Migration
  def change
    create_table :order_cars do |t|
      t.string :chassi
      t.string :country
      t.references :car_template, index: true, foreign_key: true
      t.references :customer, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
