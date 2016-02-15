require 'rails_helper'

RSpec.feature 'Customer' do
  let(:cust) { FactoryGirl.create(:customer, name: 'Edit Test') }
  describe 'GET #new' do
    it 'creates a Customer' do
      visit new_customer_path
      fill_in 'customer_name', with: 'Marcus'
      click_button('Kunden Bestätigen')

      expect(page).to have_content('Kunde erfolgreich angelegt')
      expect(page).to have_content('Marcus')
    end 
  end
    
  describe 'GET #edit' do
    it 'edits a competitor_car and redirects to index' do
      visit edit_customer_path(cust.id)

      fill_in 'customer_name', with: 'Edited'
      click_button('Kunden Bestätigen')

      expect(page).to have_content('Edited')
    end 
  end   
end