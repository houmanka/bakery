# @author Houman Kargaran - 2017
# This is the core of the application. It has some workers to process the data.

require 'validation'
require 'inventory'
require 'order_worker'
require 'order_calculator'

class Order

    extend OrderWorker
    extend OrderCalculator

    def initialize
        @customer_order = []
        @an_order_item = []
    end

    # Fetch an item upon giving it the code. It hydrates the customer order
    #
    # @param [String] - Full user input
    # @return [Boolean]

    def has_been_recorded?(order)
        unless Validation.validate(order.to_s) && Order.is_a_valid_item_code?(order.to_s)
            return false
        end
        @customer_order.push order.to_s
        return  true
    end


    # Get method for Customer Order
    #
    # @param
    # @return [Array<String>]

    def customer_order
        @customer_order
    end


    # Output of Order Class to user
    #
    # @param
    # @return [String]

    def fulfill_order
        return Order.format_order(process_customer_order)
    end

    # collection of the User Order
    #
    # @param
    # @return [Array<Hash>]
    #   sample - [ { total: 17.98, sku_number: 'VS5', qty: 14 }, [ { qty: 1, pack: 5, each_pack: 8.99}, { qty: 3, pack: 3, each_pack: 8.99}]]

    def process_customer_order

        result = []
        customer_order.each do |an_order|

            # fetch what we have got from inventory for this order
            inventory_detail = Order.fetch_from_inventory(an_order)

            # run the calculator and add it to this
            result << Order.calculate(inventory_detail, an_order)

        end

        return result
    end

end