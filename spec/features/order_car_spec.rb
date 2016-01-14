require 'rails_helper'

RSpec.feature 'OrderCar' do
#describe "creating and viewing new order_cars (sells)", type: :feature do

  it "creates a new order_car" do
    visit 'order_cars/new'
    fill_in 'order_car_chassi', with: '231442'
    fill_in 'order_car_bought_by', with: 'MUC'
    select 'Deutschland', from: 'order_car_country'
    select 'Octavia', from: 'order_car_car_template_id' #all('order_car_car_template_id').sample.select_option  #select 'Skoda', from: 'order_car_car_template_id' #car_template_id
    select 'Samer', from: 'order_car_customer_id'       #customer_id    #all('order_car_car_template_id')[2].select_option      
    click_button 'Verkauf Bestätigen'

    expect(page).to have_content '231442'       
  end 

  it 'searches for specific order_car by chassi' do

    visit 'order_cars/search/by_chassi'
    fill_in 'order_car_chassi', with: '123456'
    click_button('Verkauf Suchen')

    expect(page).to have_content('Fahrzeug gefunden')
    expect(page).to have_content('123456')
  end  

  it 'searches for specific order_car by chassi and model' do

    visit 'order_cars/search/detailed'
    fill_in 'order_car_chassi', with: '123456'
    select 'Octavia', from: 'order_car_car_template_car_template_id'
    click_button 'Verkauf Suchen'

    expect(page).to have_content('Fahrzeug gefunden')
    expect(page).to have_content('123456')
  end  



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