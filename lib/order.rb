
require 'validation'
require 'inventory'

class Order

    def initialize

        @customer_order = []
        @an_order_item = []
    end


    def has_been_recorded?(order)
         unless Validation.validate(order) && is_a_valid_item_code?(order)
             return false
         end
         @customer_order.push order
         return true
    end

    # NOTE: expected return
    # [
    #   { input: '10 VS5', total: '$17.98' },
    #   [
    #       { qty: 2, pack: 5, each_pack: '$8.99'}
    #   ]
    # ],
    # [
    #   { input: '14 MB11', total: '$54.8' },
    #   [
    #       { qty: 1, pack: 8, each_pack: '$24.95'},
    #       { qty: 3, pack: 2, each_pack: '$9.95'}
    #   ]
    # ]

    def calculate
        inventory_detail = {}

        customer_order.each do |an_order|

            # fetch what we have got from inventory for this order
            inventory_detail = fetch_from_inventory(an_order)

            # grab all of the packs
            packs = inventory_detail.map{ |x| x[:pack] }.reject(&:nil?)



        end

        return inventory_detail
    end

    # process order is the worker
    # return
    #  [
    #       { qty: 2, pack: 5, each_pack: '$8.99'}
    #   ]
    # params:
    #   single_pack = [{:pack=>3, :price=>6.99}, {:pack=>5, :price=>8.99}, {:code=>"VS5"}]
    #   order: '10 VS5'

    def process_the_order(single_pack, order)

        # VS5 package object has [3,5] then sort Great to Small, it and clean it
        packages = single_pack.map{ |x| x[:pack] }.reject(&:nil?).sort {|a,b| b <=> a}

        # extract order code and quantity
        order_code_and_quantity = extract_code_qty(order)

        # let a worker to calculate the best combination
        # packages: [3,5], order_code_and_quantity: (int)10 - Must be int
        best_combination = calculate_the_smallest_package(
            packages,
            order_code_and_quantity[:qty].to_i
        )

        # calculate the price
          best_price = calculate_price( best_combination, single_pack)


        return best_price
    end






    # return:
    #   [5,5]
    # params:
    #   packs: [5,3],
    #   target_number = 10,
    #   combination: [Used to collect],
    #   bucket: [as tracking and saving incremental]
    # reference:
    #    this is Ruby Subset Sum problem
    #    http://www.janbussieck.com/subset-sum-problem-in-ruby/

    def calculate_the_smallest_package(packs, target_number, combination = [], bucket = [])

        # count the items in the bucket each time
        collected = bucket.reduce(0, :+)

        if collected == target_number
            combination.push bucket
        end

        # make sure it is to_i
        return if collected >= target_number.to_i

        # grab the smallest number or make it zero so it can re-run
        current_pack = bucket.last || 0

        left_over = packs.select {  |x| x >= current_pack  }

        # needs to add the left over of pack selection to the bucket
        # If don't then it will never terminate
        left_over.each do |x|
            calculate_the_smallest_package(left_over, target_number, combination,  bucket + [x] )
        end

        return combination.flatten.sort {|a,b| b <=> a}
    end

    # Calculating the price
    # return:
    #   $17.98 (text)
    # params:
    #   combination: [5,5],
    #   single_pack = [{:pack=>3, :price=>6.99}, {:pack=>5, :price=>8.99}, {:code=>"VS5"}],
    # Note:
    #    this is a good candidate for refactoring

    def calculate_price( combination, single_pack)

        # shitty code, Need to refactor this
        # double loop through the single pack and match it to the pack size
        prices = []
        single_pack.each do |item|
             combination.each do |pack_size|
                 if pack_size == item[:pack]
                     prices.push (item[:price])
                 end
             end
        end

        # sum everything up
        total = prices.reduce(0){|x,y| x + y }.round(2)

        return "$#{total}"

    end

    # directly grab it from inventory
    def fetch_from_inventory(an_order)
        order = extract_code_qty(an_order)
        Inventory.new
        return Inventory.new.fetch_an_item(order[:code])
    end


    def customer_order
        @customer_order
    end

    def is_a_valid_item_code?(order)
        result = false

        an_order = extract_code_qty(order)
        return false if an_order[:code].nil?
        Inventory.new
        an_item = Inventory.new.fetch_an_item(an_order[:code])

        if an_item.size > 0
            result = true
        end

        return result
    end

    private
    def extract_code_qty(order)
        return false if order.nil?
        order_item = order.split(' ')

        return Hash[[:qty, :code].zip order_item]
    end

end