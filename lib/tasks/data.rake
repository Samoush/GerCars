namespace :data do
  desc 'Kreiere Testdaten - Cars und Customers'
  task :examples => :environment do
    
    FactoryGirl.create(:car_template, brand: 'Skoda', model: 'Octavia')         
    FactoryGirl.create(:car_template, brand: 'VW', model: 'Golf')
    FactoryGirl.create(:car_template, brand: 'Mercedes-Benz', model: 'E200')
    FactoryGirl.create(:car_template, brand: 'Skoda', model: 'Superb')

    FactoryGirl.create(:customer, name: 'Samer')                
                                                            
    bought_by = %w(MUC Robert GermanCars)
    auctions = %w(Leaseplan, CarsOnTheWeb, Autobid, mobile, autoscout24)

    5.times do
      FactoryGirl.create(:customer)
      FactoryGirl.create(:competitor_car, auction: auctions[rand(0..4)])
    end  
    15.times do
      zufall_template_and_customer = rand(4)+1
      hash_countries = {1 => 'Deutschland', 2 => 'Spanien', 3 => 'Tschechien'}
      zufall_country = rand(3)+1
      sleep 2                       #damit created_at von order_car unterschiedlich sind
      FactoryGirl.create(:order_car, car_template_id: zufall_template_and_customer, country: hash_countries[zufall_country], customer_id: zufall_template_and_customer, bought_by: "#{bought_by[rand(3)]}")
    end  
    FactoryGirl.create(:order_car, chassi: '123456', car_template_id: 1, bought_by: "#{bought_by[rand(3)]}")
    puts 'Created some Example CarTemplates, Customers and Cars (Competitors, Orders)...'
  end    
end    
#:order car creation unnötig (zufall_template_and_customer => macht schon mein factory für mich !!!)