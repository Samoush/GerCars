require 'weather_forecast'

class OrderCarsController < ApplicationController
  before_action :set_order_car, only: [:show, :edit, :update, :destroy]

  def index
    @order_cars = OrderCar.all  
    
    #forecast = WeatherForecast.new
    #@forecast_data = forecast.show         
  end  

  def show 
  end  

  def new
    @order_car = OrderCar.new
  end 

  def create
    @order_car = OrderCar.new(order_car_params)
    if @order_car.save
      flash[:notice] = "Ihr Fahrzeug wurde Erfolgreich erstellt!"
      redirect_to (order_cars_url)                   
    else
      render 'edit'
    end 
  end

  def edit
  end
  
  def update
    if @order_car.update_attributes(order_car_params)
      flash[:notice] = "Fahrzeug Aktualisiert"
      redirect_to (order_cars_path)                 
    else 
      render 'edit'
    end  
  end  

  def destroy 
    @order_car.destroy
    respond_to do |format|
      format.html { redirect_to order_cars_path, notice: 'Fahrzeug gelöscht' }
      format.json { head :no_content }
    end
  end  

  def link_to_by_chassi 
    render 'order_cars/link_to_by_chassi'
  end  

  def by_chassi    
    if OrderCar.validate_exact_six_digits_for_search_by_chassi_and_chassi_exists(params[:order_car][:chassi])                        
      @order_car = OrderCar.find_with_chassi(params[:order_car][:chassi])     
      flash[:success]  = 'Fahrzeug gefunden'                              #Farbe ändern
      render 'order_cars/show'
    else
      flash[:error] = 'Entweder die Chassi existiert nicht oder Sie achten darauf dass die Chassi 6-stellig ist!'
      render 'order_cars/not_found.html.erb'
    end    
  end

  def link_to_by_detailes                                                   
    render 'order_cars/link_to_by_detailes'
  end  

  def detailed
    if OrderCar.validate_exact_six_digits_for_search_detailed(params[:order_car][:chassi])
      @order_car = OrderCar.detailed_search(params[:order_car][:chassi], params[:order_car][:model]) 
      if @order_car.chassi != nil
        flash[:success] = 'Fahrzeug gefunden'                               #Farbe ändern
        render 'order_cars/show' 
      end   
    else
      #flash[:error] = 'Entweder die Chassi existiert nicht oder Sie achten darauf dass die Chassi 6-stellig ist!'
      #render 'order_cars/link_to_by_detailes.html.erb'
      render 'order_cars/not_found_detailed.html.erb'
    end  
  end  

  private

  def set_order_car
    @order_car = OrderCar.find(params[:id])
  end  

  def order_car_params
    params.require(:order_car).permit(:chassi, :customer_id, :car_template_id, :country, :created_at, :updated_at, :bought_by)
  end  

  def car_template_params
    params.require(:car_template).permit(:model)
  end
end
