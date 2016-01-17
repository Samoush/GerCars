class CustomersController < ApplicationController
  before_action :set_customer, only: [:edit, :destroy, :update]

  def new
    @customer = Customer.new
  end

  def index
    @customers = Customer.all
  end  

  def create 
    @customer = Customer.new(customer_params)
    #@customer.update_attribute(:name, set_capital_letter(params[:name]))
    if @customer.save
      flash[:notice] = "Kunde erfolgreich angelegt"             #flash[:succes] => wenn ich eine rot farbene einblendung möchte
      redirect_to (customers_url)                   
    else
      render 'edit'
    end   
  end  

  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_url, notice: 'Kunde gelöscht' }
      format.json { head :no_content }
    end
  end  

  def edit
  end  

  def update
    if @customer.update_attributes(customer_params)
      flash[:success] = "Kundendaten aktualisiert"
      redirect_to (customers_url)                 
    else 
      render 'edit'
    end  
  end

  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_url, notice: 'Kunde gelöscht' }
      format.json { head :no_content }
    end
  end  

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end  

  def customer_params
    params.require(:customer).permit(:name, :created_at, :updated_at)
  end
end