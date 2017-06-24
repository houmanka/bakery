require 'order'
require 'order_worker'
require 'order_calculator'
require 'support/let_singleton'

describe OrderCalculator do

    # initialise it so when we go to order it acts the same way
    class Order
    end

    before(:each) do
        @order_class = Order.new
        @order_class.extend(OrderCalculator)
    end

    let (:singleton) {
        LetSingleton.instance
    }



    # this calculation method return always have the hash summary at first
    # - [ { total: 17.98, sku_number: 'VS5', qty: 14 }, [ { qty: 1, pack: 5, each_pack: 8.99}, { qty: 3, pack: 3, each_pack: 8.99} ] ]
    # - ( [{:pack=>2, :price=>9.95}, {:pack=>5, :price=>16.95}], '14 MB11' )
    it 'expects to process the order in correct format return'  do
        process_the_order = @order_class.calculate(singleton.single_pack, singleton.sample_orders[:valid_orders].first)
        expect( process_the_order.first[:summery] ).to include( :total, :sku_number, :qty )
    end

    it 'expect to calculate all the possible combinations'   do
        calculation = @order_class.calculate_package_combinations(singleton.package_combination_feed[:packs], singleton.package_combination_feed[:qty])
        expect( calculation ).to match_array(singleton.all_of_combinations)
    end

    # it needs to accept the best picked package and calculate the price based on the package
    it 'expects to calculate the total price' do
        calculation = @order_class.calculate_price_for_best_combination(singleton.all_of_combinations,singleton.single_pack)
        expect(calculation).to be_instance_of(Hash)
        expect(calculation).to include(:total, :best_combination)
    end


end