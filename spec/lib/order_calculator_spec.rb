require 'order'
require 'order_worker'
require 'order_calculator'
require 'blueberry_muffin'
require 'vegemite_scroll'
require 'croissant'
require 'validation'

describe OrderCalculator do

    # initialise it so when we go to order it acts the same way
    class Order
    end

    before(:each) do
        @order_class = Order.new
        @order_class.extend(OrderCalculator)
    end

    let(:item_codes) {
        {
            :valid_code => '12 MB11',
            :invalid_code => '12 MB11ee',
            :order_series => [ '12 MB11', nil, ' ABM', '12 VSff' ],
            :valid_product_hash => {:qty => '12', :code => 'MB11'}
        }
    }

    let (:single_pack) {
        Order.fetch_from_inventory(item_codes[:valid_code])
    }

    let (:all_of_combinations) {
        [ [2, 2, 2, 2, 2, 2, 2], [2, 2, 2, 8], [2, 2, 5, 5] ]
    }

    let (:package_combination_feed) {
        {
            :packs => [8,5,2],
            :qty => 14
        }
    }



    # this calculation method return always have the hash summary at first
    # - [ { total: 17.98, sku_number: 'VS5', qty: 14 }, [ { qty: 1, pack: 5, each_pack: 8.99}, { qty: 3, pack: 3, each_pack: 8.99} ] ]
    # - ( [{:pack=>2, :price=>9.95}, {:pack=>5, :price=>16.95}], '14 MB11' )
    it 'expects to process the order in correct format return'  do
        process_the_order = @order_class.calculate(single_pack, item_codes[:valid_code])
        expect( process_the_order.first[:summery] ).to include( :total, :sku_number, :qty )
    end

    it 'expect to calculate all the possible combinations'   do
        calculation = @order_class.calculate_package_combinations(package_combination_feed[:packs], package_combination_feed[:qty])
        expect( calculation ).to match_array(all_of_combinations)
    end

    # it needs to accept the best picked package and calculate the price based on the package
    it 'expects to calculate the total price' do
        puts calculation = @order_class.calculate_price_for_best_combination(all_of_combinations,single_pack)
        expect(calculation).to be_instance_of(Hash)
        expect(calculation).to include(:total, :best_combination)
    end


end