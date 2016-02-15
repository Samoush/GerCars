require 'rails_helper'

RSpec.feature 'Backup' do
  describe '#do_backup' do
    it 'creates a Backup' do
      visit order_cars_path

      click_link('Backup')

      expect(page).to have_content('Ihr Backup')
      expect(page).to have_content('wurde erfolgreich versendet, schauen Sie in ihr Email Postfach')
    end  
  end  
end  