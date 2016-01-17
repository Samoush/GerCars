# == Schema Information
#
# Table name: order_cars
#
#  id              :integer          not null, primary key
#  chassi          :string(255)
#  country         :string(255)
#  car_template_id :integer
#  customer_id     :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  bought_by       :string(255)
#


require 'rails_helper'

RSpec.describe OrderCarsController, type: :controller do
  render_views
  let(:oc) { OrderCar.first }

  def find_order_car(id)
    order_car = OrderCar.find(id)
  end  

  def random_chassi
    rand(100000..999999).to_s
  end  

  describe 'GET #search_by_chassi and #search_by_detail' do

    it 'should be succesful (by_chassi)' do
      get :link_to_by_chassi
      expect(response).to render_template(:link_to_by_chassi)
      expect(response).to have_http_status(200)
    end  

    it 'should be succesful (by_detail)' do
      get :link_to_by_detailes
      expect(response).to render_template(:link_to_by_detailes)
      expect(response).to have_http_status(200)
    end  
  end

  describe 'POST #by_chassi and #by_detail' do
    it 'renders not_found template if search by chassi fails' do          
      post :by_chassi, order_car: { chassi: '122' } 

      expect(response).to render_template('order_cars/not_found.html.erb')
      expect(response).to have_http_status(200)
    end

    #it 'renders not_found_detail if search by detail fails' do

    #  example_not_existing_chassi = random_chassi
    #  while OrderCar.where(chassi: example_not_existing_chassi) == nil
    #    example_not_existing_chassi = random_chassi
    #  end  
     
    #  post :detailed, order_car: { chassi: example_not_existing_chassi, car_template: { car_template_id: 1 } } 

    #  expect(response).to render_template('order_cars/not_found_detailed.html.erb')
    #end  
  end

  describe 'GET #index #new' do
    it 'creates an order_car #index' do
      get :index
      expect(response).to render_template(:index)
      expect(response).to have_http_status(200)
    end

    it 'renders succesfully #new' do
      get :new
      expect(response).to render_template(:new)
      expect(response).to render_template('_form')
      expect(response).to have_http_status(:success)
    end  
  end 

  describe 'GET #edit' do
    before(:each) { get :edit, id: oc.id}

    it 'should be successfully' do
      expect(response).to be_success
    end  

    it 'should be successfully rendered' do
      expect(response).to render_template(:edit)
      expect(response).to render_template('_form')
      expect(response).to have_http_status(:success)
      #expect(response).to have_content(oc.chassi)
    end  
  end

  describe 'GET #show' do
    before (:each) { get :show, id: oc.id }

    it 'should be success' do
      expect(response).to be_success
    end  

    it 'should be successfully' do
      expect(response).to render_template(:show)
      expect(response).to have_http_status(:success)
    end  
  end
end  
