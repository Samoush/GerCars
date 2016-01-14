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

  describe 'GET #index' do
    it 'should be succesfull (rendering index template)' do
      get :index
      expect(response).to render_template(:index)
      expect(response).to have_http_status(200)
    end  
  end  


end  
