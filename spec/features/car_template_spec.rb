require 'rails_helper'

RSpec.feature 'CarTemplate' do

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