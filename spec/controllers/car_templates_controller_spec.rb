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

require 'rails_helper'

RSpec.describe CarTemplatesController, type: :controller do
  render_views

  describe 'GET #index #new' do
    it 'should be succesfull' do
      get :new
      expect(response).to render_template(:new)
      expect(response).to render_template('_form')
      expect(response).to have_http_status(:success)
    end 

    it 'should be succesfull' do
      get :index
      expect(response).to render_template(:index)
      expect(response).to have_http_status(200)
    end
  end  

  describe 'GET #edit' do
    let(:car_t) { CarTemplate.first } #CarTemplate.find.first
    before(:each) { get :edit, id: car_t.id }

    it 'should be success' do
      expect(response).to be_success
    end  

    it 'should be succesfully rendered' do
      expect(response).to render_template('edit')
      expect(response).to render_template('_form')
      expect(response).to have_http_status(:success)
    end  
  end  
end  
