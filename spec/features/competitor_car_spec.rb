require 'rails_helper'

RSpec.feature 'CompetitorCar' do

  it 'creates a competitor_car and redirects to index' do
    visit 'competitor_cars/new'
    fill_in 'competitor_car_competitor_name', with: 'Maximilian'
    fill_in 'competitor_car_auction', with: 'mobile'
    select 'Octavia', from: 'competitor_car_car_template_id'
    select '13', from: 'competitor_car_sold_date_3i'
    select 'Januar', from: 'competitor_car_sold_date_2i'
    select '2016', from: 'competitor_car_sold_date_1i'
    fill_in 'competitor_car_sold_car_notices', with: 'Das ist mein Beispieltext'

    click_button 'Konkurrenzkauf Bestätigen'

    expect(page).to have_content('Das ist mein Beispieltext')
  end  



end  