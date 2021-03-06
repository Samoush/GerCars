require 'rails_helper'

def search_car_template(template_id)
  found_templates = CarTemplate.order("Rand()").first(3)
  random_template = rand(0..2)
  if found_templates[random_template].id != template_id
    found_templates[random_template].id
  else 
    search_car_template(template_id)
  end    
end  

RSpec.feature 'CompetitorCar' do
  let(:competitor_c) { FactoryGirl.create(:competitor_car, competitor_name: 'Edit Test') }
  
  describe '#new' do
    it 'creates a competitor_car and redirects to index' do
      visit new_competitor_car_path
      fill_in 'competitor_car_competitor_name', with: 'Maximilian'
      fill_in 'competitor_car_chassi', with: '123123'
      fill_in 'competitor_car_auction', with: 'mobile'
      select 'Octavia', from: 'competitor_car_car_template_id'
      select '13', from: 'competitor_car_sold_date_3i'
      select 'Januar', from: 'competitor_car_sold_date_2i'
      select '2016', from: 'competitor_car_sold_date_1i'
      fill_in 'competitor_car_sold_car_notices', with: 'Das ist mein Beispieltext'

      click_button 'Konkurrenzkauf Bestätigen'

      expect(page).to have_content('Konkurrenzkauf erfolgreich registriert')
      expect(page).to have_content('Das ist mein Beispieltext')
      expect(page).to have_content('123123')
    end 
  end  

  describe '#edit' do
    it 'edits a competitor_car and redirects to index' do
      visit edit_competitor_car_path(competitor_c.id)
      fill_in 'competitor_car_competitor_name', with: 'Edited'
      fill_in 'competitor_car_sold_car_notices', with: 'This is my edited Ressource'

      click_button 'Konkurrenzkauf Bestätigen'

      expect(page).to have_content('Edited') 
      expect(page).to have_content('This is my edited Ressource') 
    end
  end

  describe '#show' do
    it 'selects and views a competitor_car with all its attributes' do
      visit competitor_car_path(competitor_c.id)

      expect(page).to have_content('Edit Test')
    end   
  end  

  describe '#search_by_chassi' do
    it 'searches a competitor_car by chassi' do
      visit competitor_cars_search_by_chassi_path
      fill_in 'competitor_car_chassi', with: "#{competitor_c.chassi}"

      click_button 'Konkurrenzkauf Suchen'

      expect(page).to have_content("#{competitor_c.chassi}")
    end

    it 'does not find by chassi' do
      visit competitor_cars_search_by_chassi_path
      fill_in 'competitor_car_chassi', with: "#{Random.rand(111111..999999).to_s}"

      click_button 'Konkurrenzkauf Suchen'

      expect(page).to have_content("Die Chassi wurde nicht gefunden")
    end  
  end  

  describe '#search_by_detailes' do
    let(:competitor_c2) { FactoryGirl.create(:competitor_car, chassi: competitor_c.chassi, car_template_id: search_car_template(competitor_c.car_template_id)) }
    it 'searches a competitor_car by detailes' do
      visit competitor_cars_search_detailed_path

      fill_in 'competitor_car_chassi', with: "#{competitor_c2.chassi}"
      select "#{CarTemplate.find(competitor_c2.car_template_id).model}", from: 'competitor_car_car_template_car_template_id'

      click_button 'Konkurrenzkauf Suchen'

      expect(page).to have_content("Verkauf")
      expect(page).to have_content("#{competitor_c2.chassi}")
      expect(page).to have_content("#{competitor_c2.car_template_id}")
    end
    let(:competitor_c3) { FactoryGirl.create(:competitor_car, chassi: competitor_c.chassi, car_template_id: competitor_c2.car_template_id) }
    it 'searches a competitor_car, finds 2 identical model and chassi - competitor_cars and renders index template' do
      visit competitor_cars_search_detailed_path

      fill_in 'competitor_car_chassi', with: "#{competitor_c2.chassi}"
      select "#{CarTemplate.find(competitor_c2.car_template_id).model}", from: 'competitor_car_car_template_car_template_id'

      click_button 'Konkurrenzkauf Suchen'

      expect(page).to have_content("Konkurrenz Käufe")  
      expect(page).to have_content("#{competitor_c2.chassi}")
      expect(page).to have_content("#{competitor_c2.car_template_id}")    
    end  
  end
end  