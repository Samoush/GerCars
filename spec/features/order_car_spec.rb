require 'rails_helper'

RSpec.feature 'OrderCar' do
#describe "creating and viewing new order_cars (sells)", type: :feature do
let (:oc) { OrderCar.first }

  describe '#new' do
    it "creates a new order_car" do
      visit new_order_car_path
      fill_in 'order_car_chassi', with: '231442'
      fill_in 'order_car_bought_by', with: 'MUC'
      select 'Deutschland', from: 'order_car_country'
      select 'Octavia', from: 'order_car_car_template_id'
      select 'Samer', from: 'order_car_customer_id'       
      click_button 'Verkauf Bestätigen'

      expect(page).to have_content '231442'       
    end 
  end  

  describe '#searches order_cars' do
    it 'searches for specific order_car by chassi' do

      visit order_cars_search_by_chassi_path
      fill_in 'order_car_chassi', with: '123456'
      click_button('Verkauf Suchen')

      expect(page).to have_content('Fahrzeug gefunden')
      expect(page).to have_content('123456')
    end  

    it 'searches for specific order_car by chassi and model' do

      visit order_cars_search_detailed_path
      fill_in 'order_car_chassi', with: '123456'
      select 'Octavia', from: 'order_car_car_template_car_template_id'
      click_button 'Verkauf Suchen'

      expect(page).to have_content('Fahrzeug gefunden')
      expect(page).to have_content('123456')
    end  
  end

  describe '#filter order_cars' do
    it 'analyses sold order_cars by given attributes' do
      visit order_cars_filter_path
      select 'Octavia', from: 'order_cars_car_template_car_template_id'
      #select 'Samer', from: 'order_cars_customer_customer_id'
      select 'Spanien', from: 'order_cars_country'

      click_button 'Analysieren'

      expect(page).to have_content('Gefilterte Verkäufe')
    end  
  end  


#  describe '#edit' do
#    it 'edits a order_car and redirects to index' do
#      visit edit_competitor_car_path(oc.id)
#      fill_in 'order_car_chassi', with: '111111'
#
#      click_button 'Verkauf Bestätigen'
#
#      expect(page).to have_content('111111') 
#    end
#  end

#  describe '#show' do
#    it 'selects and views a competitor_car with all its attributes' do
#      visit competitor_car_path(oc.id)
#
#      expect(page).to have_content('111111')
#    end   
#  end  



  #it "views a notice by deleting a order_car" do
  #  visit 'order_cars'
  #  within '.top-bar' do
  #    within '.title-area' do
  #      within '.top-bar-section' do
  #        click_link('.Neue Verkäufe')
  #      end
  #    end
  #  end      
  #  expect(page).to have_content 'Fahrzeug verkauft'
  #end
end  