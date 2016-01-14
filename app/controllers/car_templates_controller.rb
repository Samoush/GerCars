class CarTemplatesController < ApplicationController
 
# == Schema Information
#
# Table name: car_templates
#
#  id             :integer          not null, primary key
#  brand          :string(255)
#  model          :string(255)
#  general_chassi :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
  def index
    @car_templates = CarTemplate.all
  end

  def new
    @car_template = CarTemplate.new
  end
  
  def create
    @car_template = CarTemplate.new(car_template_params)
    if @car_template.save
      flash[:notice] = "Ihr Fahrzeugmuster wurde erfolgreich erstellt!"
      redirect_to (car_templates_url)                   
    else
      render 'edit'
    end   
  end  

  def edit
    @car_template = CarTemplate.find(params[:id])
  end  

  def update
    @car_template = CarTemplate.find(params[:id])

    if @car_template.update_attributes(car_template_params)
      flash[:notice] = "Fahrzeugmuster Aktualisiert"
      redirect_to (car_templates_url)                 
    else 
      render 'edit'
    end  
  end   

  def destroy
    @car_template = CarTemplate.find(params[:id])
    @car_template.destroy
    respond_to do |format|
      format.html { redirect_to car_templates_url, notice: 'Fahrzeugmuster gelöscht' }
      format.json { head :no_content }
    end
  end 
  #Das Tätigkeitsfeld der Informatik hat es mir angetan, vor allem die Webentwicklung.
  private

  def car_template_params
    params.require(:car_template).permit(:brand, :model, :general_chassi, :created_at, :updated_at)
  end

end  