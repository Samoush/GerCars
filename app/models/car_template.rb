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

class CarTemplate < ActiveRecord::Base
  has_many :order_cars, dependent: :destroy
  has_many :competitor_cars, dependent: :destroy

  validates :brand, presence: true
  validates :model, presence: true, uniqueness: true
  validates :general_chassi, presence: true, uniqueness: true

end
