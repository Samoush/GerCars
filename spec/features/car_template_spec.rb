require 'rails_helper'

RSpec.feature 'CarTemplate' do
  let(:car_t) { CarTemplate.first }  #{ FactoryGirl.create(:car_template, brand: 'Edit Test') }
  
  describe '#new' do
    it 'creates a CarTemplate' do
      visit 'car_templates/new'
      fill_in 'car_template_brand', with: 'VW'
      fill_in 'car_template_model', with: 'Touareg'
      fill_in 'car_template_general_chassi', with: 'WVWGJK9991Z'

      click_button 'Fahrzeugmuster Bestätigen'

      expect(page).to have_content('Ihr Fahrzeugmuster wurde erfolgreich erstellt')
      expect(page).to have_content('Touareg')
    end 
  end
  
#  describe '#edit' do
#    it 'edits a competitor_car and redirects to index' do
#      
#      visit edit_competitor_car_path(car_t.id)
#      fill_in 'car_template_brand', with: 'Edited'
#
#      click_button 'Fahrzeugmuster Bestätigen'
#
#      expect(page).to have_content('Edited')
#    end  
#  end    
end