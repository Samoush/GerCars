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

def random_car_template(ct_id)
  random = rand(1..10)
  if ct_id == CarTemplate.first.id 
    if CarTemplate.where(id: random).empty? || random == ct_id
      random_car_template(ct_id)
    else
      random
    end
  end      
end 

RSpec.describe CompetitorCar, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:car_template) }
  end  

#  describe 'validations' do
#    it { is_expected.to validate_presence_of :competitor_name }
#    it { is_expected.to validate_presence_of :chassi }
#    it { is_expected.to validate_presence_of :auction }
#    it { is_expected.to validate_presence_of :car_template_id }
#  end  

# => wtf was geht da ab?!
#describe 'validation' do
#  let(:comp_car) { FactoryGirl.create(:competitor_car) }
#  it 'validates succesfully' do                 

#    ap comp_car
#    expect(comp_car).to validate_presence_of :competitor_name 
#    ap comp_car
#    expect(comp_car).to validate_presence_of :auction 
#    ap comp_car
#    expect(comp_car).to validate_presence_of :car_template_id 
#    ap comp_car
#    expect(comp_car).to validate_presence_of :chassi 
#  end  
#end

  context 'valid factory' do
    it 'should have a valid Factory and CompetitorCar should be valid' do
      expect(FactoryGirl.build(:competitor_car)).to be_valid
    end
  end    

  describe 'class methods' do
    let(:competitor) { CompetitorCar.first }
    it 'executes give_the_last_ten and return the last ten created Competitors ordered by sold_date' do
      cc1 = FactoryGirl.create(:competitor_car, competitor_name: 'test1', sold_date: 1.day.ago.end_of_day)     
      cc2 = FactoryGirl.create(:competitor_car, competitor_name: 'test2', sold_date: DateTime.now)

      ordered_cc = CompetitorCar.give_the_last_ten
      
      expect(ordered_cc.size).to eq 10
      expect(ordered_cc.include?(cc1)).to be true
      expect(ordered_cc.include?(cc2)).to be true
      
      expect(ordered_cc[0]).to eq cc2

      search_index_efficient = Hash[ordered_cc.map.with_index.to_a]
      expect(search_index_efficient[cc1]).to be > search_index_efficient[cc2]
      expect(ordered_cc[0].created_at).to be > ordered_cc[ordered_cc.size-1].created_at
      expect(ordered_cc[0].created_at).to be > ordered_cc[ordered_cc.size/2].created_at
    end  

    it 'filters the right competitor_car, searched by chassi - there is only one competitor with that chassi' do
      competitor_car = CompetitorCar.first
      found_competitor_car = CompetitorCar.find_with_chassi(competitor_car.chassi)
      
      expect(found_competitor_car.chassi).to eq competitor_car.chassi
    end  

    it 'searches competitor_car by detailes' do
      different_car_template = CarTemplate.first.id

      same_chassi_different_model_competitor = FactoryGirl.create(:competitor_car, chassi: "#{competitor.chassi}", car_template_id: random_car_template(competitor.id))
      
      expect(same_chassi_different_model_competitor.car_template_id).to_not eq competitor.car_template_id

      found_competitor_car = CompetitorCar.find_with_detailes(same_chassi_different_model_competitor.chassi, same_chassi_different_model_competitor.car_template_id)

      expect(found_competitor_car.chassi).to eq competitor.chassi
      expect(found_competitor_car.car_template_id).not_to eq competitor.car_template_id
      expect(found_competitor_car.car_template_id).to eq same_chassi_different_model_competitor.car_template_id
    end  
  end  

  describe 'instance methods - validation' do
    it 'does not allow chassi to be greater or smaller than 6 digits' do
      expect(FactoryGirl.build(:competitor_car, chassi: '12345')).to be_invalid
      expect(FactoryGirl.build(:competitor_car, chassi: '123456')).to be_valid
    end  
  end  
end  

