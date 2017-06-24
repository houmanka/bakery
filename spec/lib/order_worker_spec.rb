require 'order'
require 'order_worker'
require 'blueberry_muffin'
require 'vegemite_scroll'
require 'croissant'
require 'validation'


describe OrderWorker do

    # initialise it so when we go to order it acts the same way
    class Order
    end

    before(:each) do
        @order_class = Order.new
        @order_class.extend(OrderWorker)
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
        @order_class.fetch_from_inventory(item_codes[:valid_code])
    }

    let (:sample_order_ready) {
        {:summery=>{:total=>25.85, :sku_number=>"CF", :qty=>"13"}, :line_items=>[{:qty=>1, :pack=>3, :each_pack=>5.95}, {:qty=>2, :pack=>5, :each_pack=>9.95}]}
    }



    describe 'Save the order' do

        def is_a_valid_helper(item_codes)
            @order_class.is_a_valid_item_code?(item_codes)
        end

        it 'expects to check if item code is a valid code' do
            expect(is_a_valid_helper(item_codes[:valid_code])).to be_truthy
        end

        it 'expects to return false if the item code is invalid' do
            expect(is_a_valid_helper(item_codes[:invalid_code])).to be_falsy
        end

    end

    describe 'Worker' do

        it 'expects to extract the qty and item code in Hash' do
            expect(@order_class.extract_code_qty(item_codes[:valid_code])).to include(:qty, :code)
        end

    end







end