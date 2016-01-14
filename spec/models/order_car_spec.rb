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

require 'rails_helper'

RSpec.describe OrderCar, type: :model do
  #describe 'associations' do     #testen: order erstellen und dazugehörige template suchen, wenn nicht gefunden erfolgreich
  #  it { should belong_to(:car_template).dependent(:destroy) }      #it { is_expected.to belong_to(:car_template).dependent(:destroy) }
  #  it { is_expected.to belong_to(:customer).dependent(:destroy) }
  #end  

  #describe 'validations' do

  #end  

  #it 'is dependent (destroy) from car_template and customer' do

  #  car_template = FactoryGirl.create(:car_template, brand: 'VW', model: 'Touran')
  #  car_template2 = FactoryGirl.create(:car_template, brand: 'VW', model: 'Phaeton')
  #  customer = FactoryGirl.create(:customer)

  #  order_car = FactoryGirl.create(:order_car, chassi: "235422", customer: customer, car_template: car_template)
  #  order_car2 = FactoryGirl.create(:order_car, chassi: "235422", customer: customer, car_template: car_template2)
    
  #  CarTemplate.find(car_template.id).tap do |find_and_delete_cartemplate|
  #    ap find_and_delete_cartemplate
  #    find_and_delete_cartemplate.destroy
  #  end  
  #  Customer.find(customer.id).tap do |find_and_delete_customer|
  #    ap find_and_delete_customer
  #    find_and_delete_customer.destroy
  #  end  

  #  find_order_cartemplate = []
  #  find_orderc << OrderCar.where(car_template: car_template).find_each

  #  find_order_customer = []
  #  find_order_customer << OrderCar.where(customer: customer).find_each

  #  expect(find_order_cartemplate.count).to eq 0
  #  expect(find_customer.count).to eq 0

  #end  

  it 'should have a valid factory and OrderCar should be valid' do
    expect(FactoryGirl.create(:order_car)).to be_valid        #build is alias for new 
  end  

  it 'is created and sorted by created_at in descendant order with most actual date as first element in array' do
    
    order_car = OrderCar.sort_by_created_at
    #ap order_car

    expect(order_car[0].created_at).to be > order_car[order_car.size-1].created_at       #das erste datum im array aktueller als das letzte 
    
    expect(order_car[0].created_at).to be > order_car[(order_car.size-1)/2].created_at
    expect(order_car[order_car.size-1].created_at).to be < order_car[(order_car.size-1)/2].created_at                                                                    # das element in der mitte, das datum zwischen dem ersten und dem letzten
  end

  it 'serches by chassi' do
    order_c = FactoryGirl.create(:order_car, chassi: '123444')

    found_order_car = OrderCar.find_with_chassi('123444')
   
    expect(found_order_car.chassi).to eq order_c.chassi
  end  

  it 'searches order_car using car_template (model) and order_car (chassi) - attributes' do

    car_t1 = FactoryGirl.create(:car_template, brand: 'VW', model: 'Passat')
    car_t2 = FactoryGirl.create(:car_template, brand: 'Mercedes', model: 'E250')

    cu = FactoryGirl.create(:customer)

    or_car1 = FactoryGirl.create(:order_car, chassi: "235412", customer: cu, car_template: car_t1)

    or_car2 = FactoryGirl.create(:order_car, chassi: "235412", customer: cu, car_template: car_t2) #selbe wie chassi or_car1 bloß andere car_template

    3.times do
      random_car_template = rand(3)+1
      rc = CarTemplate.find(random_car_template)
      or_car_random = FactoryGirl.create(:order_car, customer: cu, car_template: rc)
    end

    order_car_by_search = OrderCar.detailed_search(or_car1.chassi, car_t1.model)

    expect(or_car1.id).to eq order_car_by_search.id
  end  

  it 'makes sure there are not two or more identical chassis for one model (CarTemplate)' do

    cu = FactoryGirl.create(:customer)

    car_t1 = FactoryGirl.create(:car_template, brand: 'BMW', model: 'X5')
    car_t2 = FactoryGirl.create(:car_template, brand: 'BMW', model: 'X6')

    order_car_origin = FactoryGirl.create(:order_car, customer: cu, car_template: car_t1, chassi: '839212')

    order_car_different_model_same_chassi = FactoryGirl.create(:order_car, customer: cu, car_template: car_t2, chassi: '839212')
    order_car_same_chassi_and_model = FactoryGirl.create(:order_car, customer: cu, car_template: car_t1, chassi: '839212')

    expect(order_car_different_model_same_chassi).to be_valid
    expect(order_car_same_chassi_and_model).to be_invalid
    #expect(order_car_same_chassi_and_model.errors[:chassi].size).to eq 1

    #find_all_with_same_chassi_and_model = OrderCar.where(chassi: '839212')  #hier suchen wo model auch gleich ist
    #find_all_with_same_chassi_and_different_model = OrderCar.where(chassi: '839212')

    #expect(find_all_with_same_chassi_and_different_model.count).to eq 2
    #expect(find_all_with_same_chassi_and_model.count).to eq 1
  end
end

   # This option will default to `true` in RSpec 4. It makes the `description`
    # and `failure_message` of custom matchers include text for helper methods
    # defined using `chain`, e.g.:
    #     be_bigger_than(2).and_smaller_than(4).description
    #     # => "be bigger than 2 and smaller than 4"
    # ...rather than:
    #     # => "be bigger than 2"



    #expect(r.start_at).to eq start_at

    # dann aufrufen der delete action von car_template oder customer und checken ob wirklich das dazugehörige order_car gelöscht wurde

    #it 'if customer or car_template get deleted, related Orders will be deleted too' do
    #car_template = FactoryGirl.create(:car_template, brand: 'VW', model: 'Phaeton')
    #customer = FactoryGirl.create(:customer, name: 'Bassel')

    #order_car = FactoryGirl.create(:order_car, car_template: car_template.id, customer: customer.id)

