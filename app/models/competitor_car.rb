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

class CompetitorCar < ActiveRecord::Base
  belongs_to :car_template

  validates :competitor_name, presence: true
  validates :auction, presence: true
  validates :car_template_id, presence: true
  validates :chassi, presence: true
  validate :exactly_six_digits?

  def self.give_the_last_ten
    competitor_cars = CompetitorCar.find_each.sort_by{ |comp| comp.created_at }.reverse.take(10)
    competitor_cars       
  end  

  def self.find_with_chassi(chassi)      #.pluck
    comp_car = CompetitorCar.where(chassi: chassi)

    if comp_car.size == 1
      comp_car[0]
    end  
    #CompetitorCar.where(chassi: chassi).all.tap do |comp_car|
    #  ap comp_car
    #end  
  end 

  def self.find_with_detailes(chassi, car_template_id)
    comp_car_ar = []
    CompetitorCar.all.each do |comp|
      if comp.chassi == chassi && comp.car_template_id == car_template_id
        comp_car_ar << comp
      end  
    end  
    if comp_car_ar.size == 1
      comp_car_ar[0]
    elsif comp_car_ar.size > 1
      comp_car_ar
    else  
      nil
    end    
  end  

  private

  def exactly_six_digits?
    if chassi.length == 6
      true
    else
      errors.add(:chassi, 'Die Chassi muss Sechsstellig sein!')
    end    
  end 
end
