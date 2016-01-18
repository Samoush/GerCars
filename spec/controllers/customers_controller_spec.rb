# == Schema Information
#
# Table name: customers
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe CustomersController, type: :controller do
  render_views

  describe 'GET #index #new' do
    it 'should be succesfull ' do
      get :index
      expect(response).to render_template(:index)
      expect(response).to have_http_status(200)
    end  

    it 'should be succesfull ' do
      get :new
      expect(response).to render_template(:new)
      expect(response).to have_http_status(200)
    end  
  end  

  describe 'GET #edit' do
    let(:customer) { Customer.first }
    before(:each) { get :edit, id: customer.id }

    it 'should be sucessfully' do
      expect(response).to be_success
    end
    
    it 'should be sucessfully rendered' do
      expect(response).to render_template('edit')
      expect(response).to render_template('_form')
      expect(response).to have_http_status(:success)
    end  
  end  
end  
