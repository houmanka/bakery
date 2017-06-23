
require 'validation'
require 'inventory'

class Order

    def initialize

        @customer_order = []
        @an_order_item = []
    end


    def has_been_recorded?(order)

        unless Validation.validate(order.to_s) && is_a_valid_item_code?(order.to_s)
            return false
        end
        @customer_order.push order.to_s
        return  true
    end

    def fulfill_order
        return format_order(process_customer_order)
    end

    def format_order(items)

        format_lock =    items.map do |x|

                            summery =  x.first[:summery]
                            puts "#{summery[:qty]} #{summery[:sku_number]} $#{summery[:total]}\n"

                            x.first[:line_items].each do |line_item|
                                puts "\t#{line_item[:qty]} X #{line_item[:pack]} $#{line_item[:each_pack]}\n"
                            end

                            puts '---'* 5
                        end
        return format_lock

    end


    # collection of the User Order
    # return
    #  [
    #       { total: 17.98, sku_number: 'VS5', qty: 14 },
    #       [
    #           { qty: 1, pack: 5, each_pack: 8.99}
    #           { qty: 3, pack: 3, each_pack: 8.99}
    #       ]
    #   ]

    def process_customer_order

        result = []
        customer_order.each do |an_order|

            # fetch what we have got from inventory for this order
            inventory_detail = fetch_from_inventory(an_order)

            # run the calculator and add it to this
            result << calculate(inventory_detail, an_order)

        end

        return result
    end

    # process order is the worker
    # return
    #  [
    #       { total: 17.98, sku_number: 'VS5', qty: 14 },
    #       [
    #           { qty: 1, pack: 5, each_pack: 8.99}
    #           { qty: 3, pack: 3, each_pack: 8.99}
    #       ]
    #   ]
    # params:
    #   single_pack = [{:pack=>2, :price=>9.95}, {:pack=>5, :price=>16.95}, {:pack=>8, :price=>24.95}]
    #   order: '14 MB11'
    # NOTE:
    #   Good candidate for refactoring

    def calculate(single_pack, order)

        result = []

        # VS5 package object has [3,5] then sort Great to Small, it and clean it
        packages = single_pack.map{ |x| x[:pack] }.reject(&:nil?).sort {|a,b| b <=> a}

        # extract order code and quantity
        order_code_and_quantity = extract_code_qty(order)
        8
        # let a worker to calculate the best combination
        # packages: [3,5], order_code_and_quantity: (int)10 - Must be int
        package_combinations = calculate_package_combinations(
            packages,
            order_code_and_quantity[:qty].to_i
        )

        # calculate the price {:total=>53.8, :best_combination=>{2=>2, 5=>2}}
        best_price_combo = calculate_price_for_best_combination( package_combinations, single_pack)


        format = []
        best_price_combo[:best_combination].each do |key, value|
            format <<
                {
                    :qty => value,
                    :pack => key,
                    :each_pack =>
                        single_pack.map { |x| x.values}.to_h.select { |t| t == key }.values.first
                }

        end

        result << {
            :summery => {
                :total => best_price_combo[:total].round(2),
                :sku_number => order_code_and_quantity[:code],
                :qty =>  order_code_and_quantity[:qty]
            },
            :line_items => format

        }



        return result
    end


    # return:
    #   [[2, 2, 2, 2, 2, 2, 2], [2, 2, 2, 8], [2, 2, 5, 5]]
    # params:
    #   packs: [8,5,2],
    #   target_number = 14,
    #   combination: [Used to collect],
    #   bucket: [as tracking and saving incremental]
    # reference:
    #    this is Ruby Subset Sum problem
    #    http://www.janbussieck.com/subset-sum-problem-in-ruby/

    def calculate_package_combinations(packs, target_number, combination = [], bucket = [])

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
        left_over.each do |item|
            calculate_package_combinations(left_over, target_number, combination,  bucket + [item] )
        end




        return combination
    end

    # Calculating the price
    # return:
    #   {:total=>53.8, :best_combination=>{2=>2, 5=>2}}
    # params:
    #   combination: [ [2, 2, 2, 2, 2, 2, 2], [2, 2, 2, 8], [2, 2, 5, 5] ],
    #   single_pack = [
    #           {:pack=>2, :price=>9.95}, {:pack=>5, :price=>16.95}, {:pack=>8, :price=>24.95}, {:code=>"VS5"}
    #   ]

    def calculate_price_for_best_combination( combination, single_pack)

        single_pack.pop
        result = []

        # [ {2=>7}, {2=>3, 8=>1}, {2=>2, 5=>2}]
        combination_qty = combination.map { |x| x.uniq.map{|t| [t, x.count(t)]}.to_h }

        # result will be {2=>9.95, 5=>16.95, 8=>24.95}
        single_pack.each { |k| result << k.values }

        # reference: http://ruby-doc.org/stdlib-2.4.0/libdoc/matrix/rdoc/Matrix.html
        # This is better to be done using Matrix. I should read on the doc.
        # outcome should be [ 69.64, 54.8, 53.8]
        total_array = combination_qty.map{|a1| a1.keys.map{|a1k| (result.to_h[a1k]*a1[a1k]).round(2) }.inject(:+)}

        # This is easier to test.
        # the smallest with the index [ 53.8, 2]
        # we need to determine which combination got the least
        best_combination = combination_qty[total_array.each_with_index.min.last]

        return  { :total => total_array.min, :best_combination => best_combination }

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

        an_order = extract_code_qty(order.to_s)

        an_item = Inventory.new.fetch_an_item(an_order[:code].to_s)
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