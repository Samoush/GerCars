class CustomersController < ApplicationController

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
    @customer = Customer.find(params[:id])
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_url, notice: 'Kunde gelöscht' }
      format.json { head :no_content }
    end
  end  

  def edit
    @customer = Customer.find(params[:id])
  end  

  def update
    @customer = Customer.find(params[:id])

    if @customer.update_attributes(customer_params)
      flash[:success] = "Kundendaten aktualisiert"
      redirect_to (customers_url)                 
    else 
      render 'edit'
    end  
  end

  def destroy
    @customer = Customer.find(params[:id])

    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_url, notice: 'Kunde gelöscht' }
      format.json { head :no_content }
    end
  end  

  private

  def customer_params
    params.require(:customer).permit(:name, :created_at, :updated_at)
  end
end