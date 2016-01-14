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

RSpec.describe CarTemplate, type: :model do

  it 'should have a valid factory and CarTemplate should be valid' do
    expect(FactoryGirl.create(:car_template)).to be_valid        #build is alias for new 
  end
end
