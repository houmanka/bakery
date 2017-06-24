require 'order'
require 'order_worker'
require 'blueberry_muffin'
require 'vegemite_scroll'
require 'croissant'
require 'validation'
require 'support/let_singleton'


describe OrderWorker do

    # initialise it so when we go to order it acts the same way
    class Order
    end

    before(:each) do
        @order_class = Order.new
        @order_class.extend(OrderWorker)
    end

    let (:singleton) {
        LetSingleton.instance
    }


    let (:single_pack) {
        @order_class.fetch_from_inventory(singleton.sample_orders[:valid_orders].first)
    }

    let (:valid_order) {
        singleton.sample_orders[:valid_orders].first
    }



    describe 'Save the order' do

        def is_a_valid_helper(item_codes)
            @order_class.is_a_valid_item_code?(item_codes)
        end

        it 'expects to check if item code is a valid code' do
            expect(is_a_valid_helper(valid_order)).to be_truthy
        end

        it 'expects to return false if the item code is invalid' do
            expect(is_a_valid_helper(singleton.sample_orders[:invalid_orders].first)).to be_falsy
        end

    end

    describe 'Worker' do

        it 'expects to extract the qty and item code in Hash' do
            expect(@order_class.extract_code_qty(valid_order)).to include(:qty, :code)
        end

    end

end