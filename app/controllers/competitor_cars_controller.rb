# == Schema Information
#
# Table name: competitor_cars
#
#  id               :integer          not null, primary key
#  competitor_name  :string(255)
#  auction          :string(255)
#  car_template_id  :integer
#  sold_car_notices :text(65535)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  sold_date        :datetime
#

class CompetitorCarsController < ApplicationController
  before_action :set_competitor_car, only: [:show, :edit, :update, :destroy]

  def index
    @competitor_cars = CompetitorCar.give_the_last_ten            #brauche ich eigentlich nicht, weil schon im model gemacht wird
  end  

  def new
    @competitor_car = CompetitorCar.new
  end

  def show
    
  end 

  def edit
    
  end
  
  def create  
    @competitor_car = CompetitorCar.new(competitor_car_params)

    if @competitor_car.save
      flash[:notice] = "Konkurrenzkauf erfolgreich registriert"           
      redirect_to (competitor_cars_url)                   
    else
      render 'edit'
    end   
  end

  def update

    if @competitor_car.update_attributes(competitor_car_params)
      flash[:notice] = "Konkurrenzkauf aktualisiert"
      redirect_to (competitor_cars_url)
    else
      render 'edit'  
    end  
  end  

  def destroy
    
    @competitor_car.destroy
    respond_to do |format|
      format.html { redirect_to competitor_cars_url, notice: 'Konkurrenzkauf gelöscht' }
      format.json { head :no_content }
    end
  end  

  private

  def set_competitor_car
    @competitor_car = CompetitorCar.find(params[:id])
  end  

  def competitor_car_params
    params.require(:competitor_car).permit(:id, :competitor_name, :auction, :car_template_id, :sold_car_notices, :sold_date, :created_at, :updated_at)
  end  
end  




