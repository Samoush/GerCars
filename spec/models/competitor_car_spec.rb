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
  describe 'associations' do
    it { is_expected.to belong_to(:car_template) }
  end  

  describe 'validations' do
    it { is_expected.to validate_presence_of :competitor_name }
    it { is_expected.to validate_presence_of :auction }
    it { is_expected.to validate_presence_of :car_template_id }
  end  

  it 'should have a valid Factory and CompetitorCar should be valid' do
    expect(FactoryGirl.build(:competitor_car)).to be_valid
  end  

  describe 'class methods' do
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
  end  
end  

