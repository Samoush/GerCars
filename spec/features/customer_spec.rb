require 'rails_helper'

RSpec.feature 'Customer' do

  it 'creates a Customer' do
    visit 'customers/new'
    fill_in 'customer_name', with: 'Marcus'
    click_button('Kunden Bestätigen')

    expect(page).to have_content('Kunde erfolgreich angelegt')
    expect(page).to have_content('Marcus')

  end 
end