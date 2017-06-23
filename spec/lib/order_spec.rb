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

            expect(order.is_a_valid_item_code?('10 MB11')).to be_truthy
            expect(order.is_a_valid_item_code?('12 MB11ee')).to be_falsy
        end

        it 'needs to record the order in an array' do
             orders.each do |item|
                # has to pick only the valid ones
                  order.has_been_recorded?(item)
                  expect(order.customer_order).to include('12 MB11')
             end
        end

    end

    context 'Calculation' do

        let (:order) {
            Order.new
        }

        before(:example) {
            [ '10 VS5', '14 MB11', '13 CF' ].each do |item|
                order.has_been_recorded?(item)
            end
            @customer_order = order.customer_order
        }

        let (:single_pack) {
            order.fetch_from_inventory('10 VS5')
        }


        it 'expects to extract each order' do
            expect(@customer_order.size).to eq(3)
            expect(order.fetch_from_inventory(@customer_order[0])).to include({:code => 'VS5'})
        end

        it 'expect to calculate the smallest package' , :focus => true  do
            calculation = order.calculate_the_smallest_package([5,3], 10)
            expect( calculation ).to contain_exactly(5,5)
        end

        # it needs to accept the best picked package and calculate the price based on the package
        it 'expects to calculate the total price' do
            calculation = order.calculate_price([5,5],single_pack)
            expect(calculation).to eq('$17.98')
        end


        it 'expects to process the order in correct format return', :focus => true do
            puts process_the_order = order.process_the_order(single_pack, '10 VS5')
            expect( process_the_order ).to include(  :qty, :pack, :each_pack )
        end







    end


end