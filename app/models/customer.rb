# == Schema Information
#
# Table name: customers
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Customer < ActiveRecord::Base
  has_many :orders, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validate :set_capital_letter

  def set_capital_letter            #even if it's already set by the customer => saves a if question
    name[0] = name[0].capitalize
  end  
end
