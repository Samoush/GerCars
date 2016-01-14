# == Schema Information
#
# Table name: competitor_cars
#
#  id               :integer          not null, primary key
#  competitor_name  :string(255)
#  auction          :string(255)
#  car_template_id  :integer
#  sold_date        :datetime
#  sold_car_notices :text(65535)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'rails_helper'

RSpec.describe CompetitorCar, type: :model do
#  describe 'associations' do
#    it { is_expected.to belong_to(:car_template) }
#  end  

#  describe 'validations' do
#    it { is_expected.to validate_presence_of :competitor_name }
#    it { is_expected.to validate_presence_of :auction }
#    it { is_expected.to validate_presence_of :car_template_id }
#  end  

#  it 'should have a valid Factory and CompetitorCar should be valid' do
#    expect(FactoryGirl.build(:competitor_car)).to be_valid
#  end  
end  

