require 'securerandom'

class QuotesController < ApplicationController
  def new
  end

  def create
    q = Quote.new 
    q['range-type'] = params['range-type-select']
    q['building-type'] = params['building-type-select']


    puts q.inspect
    if params['building-type-select'] == 'residential'
      q['units'] = params['residential-appartments']
      q['stories'] = params['residential-stories']
      q['basements'] = params['residential-basements']
      
      average = (q['units'] / q['stories']).round
      lifts = (average / 6).ceil
      columns = (q['stories'] / 20).ceil
      q['elevator-shafts'] = lifts * columns

    elsif params['building-type-select'] == 'commercial'
      q['stories'] = params['commercial-stories']
      q['basements'] = params['commercial-basements']
      q['parking-spaces'] = params['commercial-parking-spaces']
      q['elevator-shafts'] = params['commercial-elevator-shafts']

    elsif params['building-type-select'] == 'corporate'
      q['stories'] = params['corporate-stories']
      q['units'] = params['corporate-units']
      q['basements'] = params['corporate-basements']
      q['parking-spaces'] = params['corporate-parking-spaces']
      q['max-occupants'] = params['corporate-max-occupants']

      occupants = q['max-occupants'] * (q['stories'] + q['basements'])
      columns = ((q['stories'] + q['basements']) / 20).round
      columns = columns == 0 ? 1 : columns
      lifts = (occupants / 1000).ceil
      liftsPerColumns = (lifts / columns).ceil
      q['elevator-shafts'] = liftsPerColumns * columns

    elsif params['building-type-select'] == 'hybrid'
      q['stories'] = params['hybrid-stories']
      q['units'] = params['hybrid-units']
      q['basements'] = params['hybrid-basements']
      q['parking-spaces'] = params['hybrid-parking-spaces']
      q['max-occupants'] = params['hybrid-max-occupants']
      q['hours'] = params['hybrid-hours']

      occupants = q['max-occupants'] * (q['stories'] + q['basements'])
      columns = ((q['stories'] + q['basements']) / 20).round
      columns = columns == 0 ? 1 : columns
      lifts = (occupants / 1000).ceil
      liftsPerColumns = (lifts / columns).ceil
      q['elevator-shafts'] = liftsPerColumns * columns

    end

    if q['range-type'] == 'standard'
      setupRatio = 0.1
      unitCost = 7565

      q['elevator-unit-cost'] = unitCost
      totalElevatorCost = q['elevator-shafts'] * unitCost
      q['setup-fees'] = totalElevatorCost * setupRatio
      q['total'] = totalElevatorCost + q['setup-fees']
      
    elsif q['range-type'] == 'premium'
      setupRatio = 0.13
      unitCost = 12345

      q['elevator-unit-cost'] = unitCost
      totalElevatorCost = q['elevator-shafts'] * unitCost
      q['setup-fees'] = totalElevatorCost * setupRatio
      q['total'] = totalElevatorCost + q['setup-fees']

    elsif q['range-type'] == 'excelium'
      setupRatio = 0.16
      unitCost = 15400

      q['elevator-unit-cost'] = unitCost
      totalElevatorCost = q['elevator-shafts'] * unitCost
      q['setup-fees'] = totalElevatorCost * setupRatio
      q['total'] = totalElevatorCost + q['setup-fees']

    end

    puts 'QUOTE ============================'
    puts q.inspect
    puts '============================ QUOTE'
   
    q.save
  end




end
