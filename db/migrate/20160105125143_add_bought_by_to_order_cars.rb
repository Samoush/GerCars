class AddBoughtByToOrderCars < ActiveRecord::Migration
  def change
    add_column :order_cars, :bought_by, :string
  end
end
