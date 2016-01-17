require 'rails_helper'

RSpec.describe CompetitorCarsController, type: :controller do
  render_views
  let(:competitor_cars) { FactoryGirl.create_list(:competitor_car, 2) }

  describe 'GET #index #new #edit' do

    it 'should be successfully rendered #index' do
      get :index
      expect(response).to render_template('competitor_cars/index')
      expect(response).to have_http_status(:success)
    end  

    it 'should be successfully rendered #new' do
      get :new
      expect(response).to render_template('competitor_cars/new')
      expect(response).to render_template(partial: '_form')
      expect(response).to have_http_status(:success)
    end  

    #it 'should be successfully rendered #edit' do
    #  get :edit, competitor_car: { id: CompetitorCar.find(1) }
    #  expect(response).to render_template('competitor_cars/edit')
    #  expect(response).to render_template(partial: 'competitor_cars/_form')
    #  expect(response).to have_http_status(:success)
    #end 

    it 'should be successfully rendered #show' do
      get :show, competitor_car: { id: CompetitorCar.find(1) }
      expect(response).to render_template('competitor_cars/show')
      expect(response).to have_http_status(:success)
    end 
  end

  describe 'GET #show' do
    context 'when request an existing CompetitorCar' do
      let(:competitor_car) { competitor_cars[rand(2)] }
      before(:each) { get :show, id: competitor_car.id }

      it 'should be successfully' do
        expect(response).to be_success
      end 
    end
  end
end    