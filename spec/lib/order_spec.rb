require 'order'
require 'blueberry_muffin'
require 'vegemite_scroll'
require 'croissant'
require 'validation'

describe Order do

    let(:order) {
        Order.new
    }

    let(:orders) {
        [ '12 MB11', nil, ' ABM', '12 VSff' ]
    }

    context 'Save the order' do

        it 'expects to check if item code is a valid code' do

            expect(order.is_a_valid_item_code?('10 VS5')).to be_truthy
            expect(order.is_a_valid_item_code?('12 MB11ee')).to be_falsy
        end

        it 'needs to record the order in an array', :focus => true do
             orders.each do |item|
                # has to pick only the valid ones
                  order.has_been_recorded?(item)
                  expect(order.customer_order).to include('12 MB11')
             end
        end

    end

    # best price calculation is incorrect


    # Array 1:
    #     arr1 = [{2=>7}, {2=>3, 8=>1}, {2=>2, 5=>2}]
    #     arr2 = [{2=>9.95, 5=>16.95, 8=>24.95}]
    #
    #     expected result [  69.65 ,  54.8 ,  53.8   ]

    # this is incorrect in terms of the question.


    context 'Calculation' do

        let (:order) {
            Order.new
        }

        let (:valid_orders) {
            [  '13 CF', '5 VS5' ]
        }

        before(:example) {
            valid_orders.each do |item|
                order.has_been_recorded?(item)
            end
            @customer_order = order.customer_order
        }

        let (:single_pack) {
            order.fetch_from_inventory('14 MB11')
        }

        let(:expected_package_combination) {
            [ [2, 2, 2, 2, 2, 2, 2], [2, 2, 2, 8], [2, 2, 5, 5] ]
        }

        # NOTE: Dont forget this one
        it 'expects to format the order return', :focus => true do
           fail
        end


        it 'expects to extract each order' do
            expect(@customer_order.size).to eq(3)
            expect(order.fetch_from_inventory(@customer_order[0])).to include({:code => 'VS5'})
        end

        it 'expect to calculate all the possible combinations'   do
            calculation = order.calculate_package_combinations([8,5,2], 14)
            expect( calculation ).to contain_exactly([2, 2, 2, 2, 2, 2, 2], [2, 2, 2, 8], [2, 2, 5, 5])
        end

        # it needs to accept the best picked package and calculate the price based on the package
        it 'expects to calculate the total price' do
            puts calculation = order.calculate_price_for_best_combination(expected_package_combination,single_pack)
            expect(calculation).to be_instance_of(Hash)
            expect(calculation).to include(:total, :best_combination)
        end

        # this calculation method return always have the hash summary at first
        it 'expects to process the order in correct format return'  do
            process_the_order = order.calculate(single_pack, '14 MB11')
            expect( process_the_order.first ).to include( :total, :sku_number, :qty )
        end

        it 'expects to process customer order' do
            customer_order = order.process_customer_order[0]
            expected = customer_order.select { |x| x.first }
            expect( expected ).to be_instance_of(Array)
        end




    end


end