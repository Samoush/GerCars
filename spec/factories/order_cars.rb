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

FactoryGirl.define do
  factory :order_car do
    chassi { Random.rand(100000..999999) }
    country "Spanien"
    car_template { CarTemplate.find(Random.rand(1..4)) }
    customer { Customer.find(Random.rand(1..4)) }
    created_at { Time.current }
  end

end
