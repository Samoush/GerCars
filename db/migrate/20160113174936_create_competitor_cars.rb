class CreateCompetitorCars < ActiveRecord::Migration
  def change
    create_table :competitor_cars do |t|
      t.string :competitor_name
      t.string :auction
      t.references :car_template, index: true, foreign_key: true
      t.datetime :sold_date
      t.text :sold_car_notices

      t.timestamps null: false
    end
  end
end
