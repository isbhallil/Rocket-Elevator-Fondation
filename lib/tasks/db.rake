require 'bcrypt'

namespace :db do


  desc "Drop, create, migrate, and repopulate with sample data"
  task repopulate: [:drop, :create, :migrate, :users, :quotes, :seed] do
  puts "Done"
  end


  task users: :environment do
    1000.times do
      User.create!(
        email: Faker::Internet.email,
        # encrypted_password: BCrypt::Password.create(Faker::Internet.password)
        encrypted_password: 12345678
      )
    end
  end


  task quotes: :environment do
    50.times do
      Quote.create!(
        building_type: Faker::Construction.material,
        range_type: Faker::Vehicle.make,
        stories: Faker::Number.within(range: 1..50),
        units: Faker::Number.within(range: 1..50),
        basements: Faker::Number.within(range: 1..10),
        max_occupants: Faker::Number.within(range: 1..100),
        parking_spaces: Faker::Number.within(range: 1..500),
        elevator_shafts: Faker::Number.within(range: 1..10),
        hours: Faker::Number.within(range: 1..24),
        elevator_unit_cost: Faker::Number.within(range: 1..50000),
        setup_fees: Faker::Number.within(range: 1..10000),
        total: Faker::Number.within(range: 1..60000),
        contact: Faker::Name.name,
        phone: Faker::PhoneNumber.cell_phone
      )
    end
  end
end