$(document).on('turbolinks:load', function () {    
  // DOCUMENT READY
  $(document).ready(function () {
      console.info('ready');
    const residentialForm = $('#residential-form');
    const commercialForm = $('#commercial-form');
    const corporateForm = $('#corporate-form');
    const hybridForm = $('#hybrid-form');
    const rangeTypeSelect = $('#range-type-select');
    const buildingTypeSelect = $('#building-type-select');
    const calcBtn = $("#calc-estimate-btn");
    const estimateEl = $("#estimate");
    const quoteBtn = $('#submit-quote')

    const budgetFeesRatios = {
      standard: {
        range: 'standard',
        setupFeeRatio: 0.10,
        elevatorUnitCost: 7565
      },
      premium: {
        range: 'premium',
        setupFeeRatio: 0.13,
        elevatorUnitCost: 12345
      },
      excelium: {
        range: 'excelium',
        setupFeeRatio: 0.16,
        elevatorUnitCost: 15400
      }
    }

    const budget = {
      range: "",
      setupFeeRatio: 0,
      elevatorUnitCost: 0,
      totalElevatorCount: 0,
      setTotalElevatorCount: function (count) {
        this.totalElevatorCount = count;
        console.log('count: ', count);
      },
      getTotalElevatorCost: function () {
        return this.totalElevatorCount * this.elevatorUnitCost
      },
      getSetupFee: function () {
        return parseFloat(this.getTotalElevatorCost() * this.setupFeeRatio)
      },
      getTotal: function () {
        return this.getTotalElevatorCost() + this.getSetupFee()
      }
    }

    // DISPLAY ELEMENT
    const showElement = function (element) {
      element.show();
    }

    // HIDE ELEMENT 
    const hideElement = function (element) {
      element.hide();
    }

    // HIDE ALL FORMS
    const hideAll = function () {
      [residentialForm, commercialForm, corporateForm, hybridForm, calcBtn , estimateEl, quoteBtn]
      .forEach(function (form) {
        form.hide();
      })
      $('#contact-quote-form').hide()
    }

    // CHECK IF ALL INPUTS OF A FORM EL. ARE FILLED
    const isFormFilled = function (form) {
      let inputsValues = getInputsValueFrom(form)

      $.each(inputsValues, function (key, value) {
        console.log(key, value)
        value == 0 ? isFilled = false : isFilled = true;
      });

      console.log('isFilled', isFilled)
    }

    // SET BUDGET WITH RANGE
    const setBudgetRange = function (range) {
      let budgetDef = budgetFeesRatios[range.value.toLowerCase()];
      $.extend(budget, budgetDef);
    }

    // RESET BUDGET
    const resetBudget = function () {
      let resetedBudgetDef = {
        range: "",
        setupFeeRatio: 0,
        elevatorUnitCost: 0,
        totalElevatorCount: 0
      }

      $.extend(budget, resetedBudgetDef);
    }

    // SET TOTAL ELEVATOR COUNT
    const setTotalElevatorCount = function (count) {
      return budget.setTotalElevatorCount(count);
    }

    // GET THE BUDGET VALUE
    const getBudget = function () {
      return budget;
    }

    // PRINT PRICE
      const printPrice = function (totalLiftCages) {
        setTotalElevatorCount(totalLiftCages)

        $("#estimate-range").html(budget.range);
        $("#estimate-total-elevators").html(budget.totalElevatorCount);
      

        $("#estimate-elevators-cost").html(budget.getTotalElevatorCost());
        $("#estimate-setup-fees").html(budget.getSetupFee());
        $("#estimate-total").html(budget.getTotal());

        // showElement(estimateEl)
        console.log(totalLiftCages, budget)
        if (totalLiftCages > 0) showElement(quoteBtn)
      }

    // CREATE AN OBJECT OUT OF THE INPUTS VALUES FOR A GIVEN FORM
    const getInputsValueFrom = function (form) {
      return Array.from(form.find('input'))
        .map(function (inputEl, index) {
          inputEl = $(inputEl)[0]

          return {
            id: inputEl.id,
            value: inputEl.value * 1,
            isRequired: inputEl.hasAttribute('required')
          };
        })
        .reduce(function (accumulator, item) {
          accumulator[item.id] = {
            value: item.value, 
            isRequired: item.isRequired
          };
          
          return accumulator;
        }, {})
    };

    // RETURN VALUE OF SELECTED OPTION
    const getSelectedItem = function (selectEl) {
      return { value: selectEl.find(":selected").text(), index: selectEl.find(":selected").index()}
    }
    
    // RANGE SELECTION
    $('#range-type-select').bind('change', function () {
      console.log("range-type-select")
      const selectedRange = getSelectedItem(rangeTypeSelect);
      const isRangeSelected = selectedRange.index != 0;

      console.log("selectedRange: ",  selectedRange)
      console.log('isRangeSelected: ', isRangeSelected)
      if (isRangeSelected == true) {
        showElement(buildingTypeSelect);
        $('#building-type-wrapper').show()
        setBudgetRange(selectedRange);
      } else if ( isRangeSelected == false ){
        hideElement(buildingTypeSelect);
        hideAll();
        resetBudget();
      }
    })

    // DISPLAY PROPER FORM ACCORDING TO BUILDING TYPE
      $('#building-type-select').change(function (ev) {
      
      
      let buildingType = getSelectedItem(buildingTypeSelect)
      console.log('buildingType: ', buildingType)  

      const residentialForm = $('#residential-form');
      const commercialForm = $('#commercial-form');
      const corporateForm = $('#corporate-form');
      const hybridForm = $('#hybrid-form');
        
      switch (buildingType.value) {
        case 'residential':
          hideAll();
          showElement(residentialForm);
          $('#contact-quote-form').show()
          break;

        case 'corporate':
          hideAll();
          showElement(corporateForm);
          $('#contact-quote-form').show()
          break;

        case 'commercial':
          hideAll();
          showElement(commercialForm);
          $('#contact-quote-form').show()
          break;

        case 'hybrid':
          hideAll();
          showElement(hybridForm);
          $('#contact-quote-form').show()
          break;

        default:
          hideAll()
      }

      showElement(calcBtn);
    })

    $('#calc-estimate-btn').click(function(){
      printPrice()
    })

      // RESIDENTIAL FORM LOGIC 
      residentialForm.bind('input', function () {
        // {residential-appartments, residential-stories, residential-basements}
        let inputsValues = getInputsValueFrom(residentialForm);
        let basements = inputsValues['residential-basements'].value;

        let appartments = inputsValues['residential-appartments'].value;
        let stories = inputsValues['residential-stories'].value;

        let averageAptsPerFloor = Math.round(appartments / stories);
        let liftCages = Math.ceil(averageAptsPerFloor / 6);
        let liftColumns = Math.ceil(stories / 20);
        let totalLiftCages = liftCages * liftColumns;

        printPrice(totalLiftCages)
      })

      // COMMERCIAL FORM LOGIC
      commercialForm.bind('input', function () {
        // {commercial-stories, commercial-basements, commercial-parking-spaces, commercial-elevator-shafts}
        let inputsValues = getInputsValueFrom(commercialForm);
        
        let stories = inputsValues['commercial-stories'].value;
        let basements = inputsValues['commercial-basements'].value;
        let parkingSpaces = inputsValues['commercial-parking-spaces'].value;
        
        
        let elevatorshafts = inputsValues['commercial-elevator-shafts'].value;
        console.log(elevatorshafts)
        let totalLiftCages = elevatorshafts;
        printPrice(totalLiftCages)
      })

      // CORPORATE FORM LOGIC
      corporateForm.bind('input', function () {
        // {commercial-stories, commercial-basements, commercial-parking-spaces, commercial-elevator-shafts}
        let inputsValues = getInputsValueFrom(corporateForm);

        let units = inputsValues['corporate-units'].value;
        let parkingSpaces = inputsValues['corporate-parking-spaces'].value;

        let stories = inputsValues['corporate-stories'].value;
        let basements = inputsValues['corporate-basements'].value;
        let maxPerFLoor = inputsValues['corporate-max-occupants'].value;

        let totalOccupants = maxPerFLoor * (stories + basements);
        let liftColumns = Math.round((stories + basements) / 20)
        let liftCages = Math.ceil(totalOccupants / 1000);
        let liftCagesPerColumn = Math.ceil(liftCages / liftColumns);
        let totalLiftCages = liftCagesPerColumn * liftColumns;

        printPrice(totalLiftCages)
      })

      // HYBRID FORM LOGIC
      hybridForm.bind('input', function () {
        // {hybrid-stories, hybrid-basements, hybrid-parking-spaces, hybrid-elevator-shafts}
        let inputsValues = getInputsValueFrom(hybridForm);

        console.log(inputsValues);

        let units = inputsValues['hybrid-units'].value;
        let parkingSpaces = inputsValues['hybrid-parking-spaces'].value;
        let hours = inputsValues['hybrid-hours'].value;

        let stories = inputsValues['hybrid-stories'].value;
        let basements = inputsValues['hybrid-basements'].value;
        let maxPerFLoor = inputsValues['hybrid-max-occupants'].value;

        let totalOccupants = maxPerFLoor * (stories + basements);
        let liftColumns = Math.round((stories + basements) / 20)
        let liftCages = Math.ceil(totalOccupants / 1000);
        let liftCagesPerColumn = Math.ceil(liftCages / liftColumns);
        let totalLiftCages = liftCagesPerColumn * liftColumns;

        printPrice(totalLiftCages)
      })

      quoteBtn.click(function () {
        console.log(budget)
      })
      
    hideAll();
    hideElement(buildingTypeSelect);
    hideElement($('#building-type-wrapper'));
  });
});