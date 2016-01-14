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

FactoryGirl.define do
  factory :car_template do
    brand "VW"
    model { Faker::Name.name }
    general_chassi { "WVWZZZ092KBA#{Random.rand(10000)}" }
  end
end
