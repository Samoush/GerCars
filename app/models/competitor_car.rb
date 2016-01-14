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

end
