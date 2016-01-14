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


FactoryGirl.define do
  factory :competitor_car do
    competitor_name { Faker::Name.name } 
    auction "MyString"
    sold_date { Time.now.strftime("%d.%m.%Y") }     #evtl. to_s
    car_template { CarTemplate.find(Random.rand(1..4)) }
    sold_car_notices "... MyText ..."
  end
end
