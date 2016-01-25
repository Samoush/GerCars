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

RSpec.describe Customer, type: :model do
  describe 'associations' do
    it { should have_many(:order_cars).dependent(:destroy) }
  end  

  context 'valid factory' do
    it 'should have a valid factory and CarTemplate should be valid' do
      expect(FactoryGirl.create(:customer)).to be_valid        #build is alias for new 
    end
  end  

  context 'validation methods' do
    it 'makes sure the first letter of the entered name is a capital letter' do
      customer = FactoryGirl.create(:customer, name: 'samer')

      expect(customer.name[0]).to eq 'S'
    end  
  end  
end
