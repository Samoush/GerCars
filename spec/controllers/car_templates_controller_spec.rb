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

  describe 'GET #index' do
    it 'should be succesfull (rendering index template)' do
      get :index
      expect(response).to render_template(:index)
      expect(response).to have_http_status(200)
    end
  end    


end  
