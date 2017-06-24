require 'order'
require 'validation'
require 'inventory'
require 'support/let_singleton'

describe Order do

    let(:order) {
        Order.new
    }

    let (:singleton) {
        LetSingleton.instance
    }

    before(:example) {
        singleton.sample_orders[:valid_orders].each do |item|
            order.has_been_recorded?(item)
        end
        @customer_order = order.customer_order
    }

    context 'Save the order' do

        it 'needs to record the order in an array' do
            valid_orders = singleton.sample_orders[:valid_orders]
            expect(order.customer_order).to match_array(valid_orders)
        end

    end

    it 'expects to extract each order' do
        expect(@customer_order).not_to be_empty
    end

    it 'expects the inventory via customer order to match the sample output' do
        expect(Order.fetch_from_inventory(@customer_order[0])).to satisfy {
            |x| x[0].include?(:pack)
        }
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