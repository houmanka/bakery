require 'order'
require 'blueberry_muffin'
require 'vegemite_scroll'
require 'croissant'
require 'validation'
require 'inventory'

describe Order do

    let(:order) {
        Order.new
    }

    let (:sample_orders) {
         {
             valid_orders: ['13 CF', '5 VS5'],
             invalid_orders: [ '12 M*11', nil, ' ABM', '12 VSff' ]
         }
    }

    let (:sample_pack) {
        [{:pack => 3, :price => 5.95}, {:pack => 5, :price => 9.95}, {:pack => 9, :price => 16.99}, {:code => 'CF'}]
    }

    before(:example) {
        sample_orders[:valid_orders].each do |item|
            order.has_been_recorded?(item)
        end
        @customer_order = order.customer_order
    }

    context 'Save the order' do

        it 'needs to record the order in an array' do
            expect(order.customer_order).to match_array(sample_orders[:valid_orders])
        end

    end

    it 'expects to extract each order' do
        expect(@customer_order).not_to be_empty
    end

    it 'expects the inventory via customer order to match the sample output' do
        expect(Order.fetch_from_inventory(@customer_order[0])).to match_array(sample_pack)
    end

    it 'expects to process customer order' do
        customer_order = order.process_customer_order[0]
        expected = customer_order.select { |x| x.first }
        expect( expected ).to satisfy{
            |x| x[0].keys.include?(:summery)
        }
    end

    describe 'Formatter' do

        # this behavior needs to be tested at the application. As it is the user output
        it 'expect to return String' do
            expect(order.fulfill_order).to be_instance_of(Array)
        end

    end

end