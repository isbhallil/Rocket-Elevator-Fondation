require 'bcrypt'

namespace :db do
  
  
  desc "Drop, create, migrate, and repopulate with sample data"
  task repopulate: [:drop, :create, :migrate, :fakeit, :seed] do
  puts "Done"
  end

  desc "TODO"
  task fakeit: :environment do
    1000.times do
      User.create!(
        
        email: Faker::Internet.email,
        # encrypted_password: BCrypt::Password.create(Faker::Internet.password)
        encrypted_password: Faker::Internet.password
      )
  end
end

desc "TODO"
  task fakeit: :environment do
    50.times do
      Quote.create!(

        'building-type': Faker::Construction.material,
        'range-type': Faker::Vehicle.make,
        stories: Faker::Number.within(range: 1..50),
        units: Faker::Number.within(range: 1..50),
        basements: Faker::Number.within(range: 1..10),
        'max-occupants': Faker::Number.within(range: 1..100),
        'parking-spaces': Faker::Number.within(range: 1..500),
        'elevator-shafts': Faker::Number.within(range: 1..10),
        hours: Faker::Number.within(range: 1..24),
        'elevator-unit-cost': Faker::Number.within(range: 1..50000),
        'setup-fees': Faker::Number.within(range: 1..10000),
        total: Faker::Number.within(range: 1..60000),
        contact: Faker::Name.name,
        phone: Faker::PhoneNumber.cell_phone
      )
    end
  end
end
