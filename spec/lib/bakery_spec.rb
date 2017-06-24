require 'bakery'
require 'language'

describe Bakery do

    let (:sample_orders) {
        {
            valid_orders: ['13 CF', '5 VS5'],
            invalid_orders: [ '12 M*11', nil, ' ABM', '12 VSff' ]
        }
    }



    context 'Bakery' do

       it 'expects to return error' do

           # feed the sample order valid

       end

     end

end