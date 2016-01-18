class AddChassiToCompetitorCar < ActiveRecord::Migration
  def change
    add_column :competitor_cars, :chassi, :string
  end
end
