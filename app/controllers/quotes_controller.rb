class QuotesController < ApplicationController
  def new
  end

  def create
    q = Quote.new
    q.range_type= params['range-type-select']
    q.building_type= params['building-type-select']

    if params['building-type-select'] == 'residential'
      q.units= params['residential-appartments']
      q.stories= params['residential-stories']
      q.basements= params['residential-basements']

      average = (q.units/ q.stories).round
      lifts = (average / 6).ceil
      columns = (q.stories/ 20).ceil
      columns = columns == 0 ? 1 : columns
      q.elevator_shafts= lifts * columns


    elsif params['building-type-select'] == 'commercial'
      q.stories = params['commercial-stories']
      q.basements = params['commercial-basements']
      q.parking_spaces = params['commercial-parking-spaces']
      q.elevator_shafts = params['commercial-elevator-shafts']


    elsif params['building-type-select'] == 'corporate'
      q.stories = params['corporate-stories']
      q.units = params['corporate-units']
      q.basements = params['corporate-basements']
      q.parking_spaces = params['corporate-parking-spaces']
      q.max_occupants = params['corporate-max-occupants']

      occupants = q.max-occupants* (q.stories+ q.basements)
      columns = ((q.stories+ q.basements) / 20).round
      lifts = (occupants / 1000).ceil
      liftsPerColumns = (lifts / columns).ceil
      q.elevator_shafts= liftsPerColumns * columns

    elsif params['building-type-select'] == 'hybrid'
      q.stories = params['hybrid-stories']
      q.units = params['hybrid-units']
      q.basements = params['hybrid-basements']
      q.parking_spaces = params['hybrid-parking-spaces']
      q.max_occupants = params['hybrid-max-occupants']
      q.hours = params['hybrid-hours']

      occupants = q.max_occupants* (q.stories+ q.basements)
      columns = ((q.stories+ q.basements) / 20).round
      lifts = (occupants / 1000).ceil
      liftsPerColumns = (lifts / columns).ceil
      q.elevator_shafts= liftsPerColumns * columns

    end

    q.elevator_shafts= q.elevator_shafts== 0 ? 1 : q.elevator_shafts

    if q.range_type== 'standard'
      setupRatio = 0.1
      unitCost = 7565
      totalElevatorCost = q.elevator_shafts.to_f * unitCost.to_f
      ap totalElevatorCost

      ap 'setup_fees: '
      q.setup_fees= totalElevatorCost.to_f / 10.to_f
      q.elevator_unit_cost = unitCost

      q.total= totalElevatorCost + q.setup_fees
      puts 'PRINT ==============================='
      ap q


    elsif q.range_type== 'premium'
      setupRatio = 0.13
      unitCost = 12345
      puts unitCost

      q.elevator_unit_cost = unitCost
      totalElevatorCost = q.elevator_shafts* unitCost
      q.setup_fees= totalElevatorCost * setupRatio
      q.total= totalElevatorCost + q.setup_fees

    elsif q.range_type== 'excelium'
      setupRatio = 0.16
      unitCost = 15400

      q.elevator_unit_cost= unitCost
      totalElevatorCost = q.elevator_shafts* unitCost
      q.setup_fees = totalElevatorCost * setupRatio
      q.total = totalElevatorCost + q.setup_fees

    end

    puts 'QUOTE ============================'
    puts q.inspect
    puts '============================ QUOTE'

    quote_summary = {
      range: q.range_type,
      type: q.building_type,
      elevator_unit_cost: q.elevator_unit_cost,
      number_of_elevators: q.elevator_shafts,
      setup_fees: q.setup_fees,
      total: q.total
    }

    if q.try(:save)
      redirect_to print_path(quote_summary)
    else
      redirect_to root_path()
    end
  end

  def print
    @quote = params
  end

end
