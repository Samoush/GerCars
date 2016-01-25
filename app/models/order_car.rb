# == Schema Information
#
# Table name: order_cars
#
#  id              :integer          not null, primary key
#  chassi          :string(255)
#  country         :string(255)
#  car_template_id :integer
#  customer_id     :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  bought_by       :string(255)
#

class OrderCar < ActiveRecord::Base
  belongs_to :car_template    #, foreign_key: 'car_template_id' #, dependent: :destroy
  belongs_to :customer     #, foreign_key: 'customer_id' #, dependent: :destroy

  validates :chassi, presence: true
  validates :country, presence: true
  validates :car_template_id, presence: true
  validates :customer_id, presence: true
  validate :exactly_six_digits?            #=> prüfen ob richtig funktioniert
  validate :unqiue_chassi_in_model?

  def self.sort_by_created_at
    order_car = OrderCar.all.sort_by{ |ord| ord.created_at }.reverse
  end  

  def self.find_with_chassi(chassi)          
    order_car = OrderCar.where(chassi: chassi).all
 
    if order_car.size == 1
      order_car[0]
    end
  end    

  def self.detailed_search(chassi, model)       
    order_car_ar = []
    OrderCar.all.each do |ord| #find_each statt .all                 
      if ord.chassi == chassi
        order_car_ar << ord
      end
    end    
         
    car_template = CarTemplate.find_by_model(model)
    found_order_car = OrderCar.new

    order_car_ar.each do |order_car|
      order_car_template = CarTemplate.find(order_car.car_template_id)
      if order_car_template.id == order_car.car_template_id
        found_order_car = order_car
        break
      end  
    end
    if found_order_car.chassi == nil
      false
    else
      found_order_car
    end  
  end 

  def self.validate_exact_six_digits_for_search_by_chassi_and_chassi_exists(chassi)
    if chassi.size == 6 && OrderCar.find_by(chassi: chassi) != nil
      true
    else
      false
    end    
  end 

  def self.validate_exact_six_digits_for_search_detailed(chassi)  
    if chassi.size == 6
      true
    else
      false
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

  def unqiue_chassi_in_model?
    car_templates = []
    oc = OrderCar.where(chassi: chassi)

    if oc.count == 1 
      true
    else  
      oc.each do |oc_template|
        car_templates = CarTemplate.where(id: oc_template.car_template).pluck(:model)
      end  

      if car_templates.uniq.length == car_templates.length && car_templates.include?(CarTemplate.find(car_template_id).model) == false
        true
      else
        errors.add(:chassi, 'Die Chassi existiert bereits im selben Fahrzeugmodell!')
      end    
    end   
  end  
end

