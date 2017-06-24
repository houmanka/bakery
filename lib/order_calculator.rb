# @author Houman Kargaran - 2017
# This module acts as a Class Module for the order. It does the calculation

module OrderCalculator

    # Using the single pack and the user full order to put together the single order result
    #
    # @note Good candidate for refactoring into another module and a class method
    # @param [Array<Hash>, String]
    # @return [<Array<Hash>]
    #   sample - [{:summery=>{:total=>43.85, :sku_number=>"MB11", :qty=>"12"}, :line_items=>[{:qty=>1, :pack=>2, :each_pack=>9.95}, {:qty=>2, :pack=>5, :each_pack=>16.95}]}]

    def calculate(single_pack, order)

        result = []

        # Sort Great to Small, it and clean it
        packages = single_pack.map{ |x| x[:pack] }.reject(&:nil?).sort {|a,b| b <=> a}

        order_code_and_quantity = Order.extract_code_qty(order)

        # let a worker to calculate the best combination
        # packages: [3,5], order_code_and_quantity: (int)10 - Must be int
        package_combinations = calculate_package_combinations(
            packages,
            order_code_and_quantity[:qty].to_i
        )

        # calculate the price {:total=>53.8, :best_combination=>{2=>2, 5=>2}}
        best_price_combo = calculate_price_for_best_combination( package_combinations, single_pack)

        package_formatter(best_price_combo, order_code_and_quantity, result, single_pack)

        return result
    end

    # (see #calculate)
    # note: don't need Test. This is just the refactor after the fact

    def package_formatter(best_price_combo, order_code_and_quantity, result, single_pack)
        format = []
        best_price_combo[:best_combination].each do |key, value|
            format <<
                {
                    :qty => value,
                    :pack => key,
                    :each_pack =>
                        single_pack.map {|x| x.values}.to_h.select {|t| t == key}.values.first
                }

        end

        result << {
            :summery => {
                :total => best_price_combo[:total].round(2),
                :sku_number => order_code_and_quantity[:code],
                :qty => order_code_and_quantity[:qty]
            },
            :line_items => format
        }
    end



    # This will calculate the package combinations, all of the possibilities.
    #
    # @param [Array, Integer, Array, Array]
    #   sample - packs: [8,5,2],
    #   sample - target_number = 14,
    #   sample - combination: [Used to collect],
    #   sample - bucket: [as tracking and saving incremental]
    # @return [Array<Integer>]
    #   sample - [[2, 2, 2, 2, 2, 2, 2], [2, 2, 2, 8], [2, 2, 5, 5]]
    # @reference:
    #    this is Ruby Subset Sum problem
    #    http://www.janbussieck.com/subset-sum-problem-in-ruby/

    def calculate_package_combinations(packs, target_number, combination = [], bucket = [])

        # count the items in the bucket each time
        collected = bucket.reduce(0, :+)

        # if the collected amount is equal the qty then push into the combination.
        if collected == target_number
            combination.push bucket
        end

        # make sure it is to_i - We are done when collected number are greater than qty
        return if collected >= target_number.to_i

        # grab the smallest number or make it zero so it can re-run - It is ordered from great -> small
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
    #
    # @param [Array<Array>,Array<Hash>]
    #   sample - combination: [ [2, 2, 2, 2, 2, 2, 2], [2, 2, 2, 8], [2, 2, 5, 5] ],
    #   sample - single_pack = [ {:pack=>2, :price=>9.95}, {:pack=>5, :price=>16.95}, {:code=>"VS5"} ]
    # @return:
    #   sample - {:total=>53.8, :best_combination=>{2=>2, 5=>2}}
    # @reference: http://ruby-doc.org/stdlib-2.4.0/libdoc/matrix/rdoc/Matrix.html
    # @note This is better to be done using Matrix. I should read on the doc.

    def calculate_price_for_best_combination( combination, single_pack)

        single_pack.pop
        result = []

        # Find how many qty exist for each given pack
        # [ {2=>7}, {2=>3, 8=>1}, {2=>2, 5=>2}]
        combination_qty = combination.map { |x| x.uniq.map{|t| [t, x.count(t)]}.to_h }

        # Find the cost of each pack
        # {2=>9.95, 5=>16.95, 8=>24.95}
        single_pack.each { |k| result << k.values }

        # mix the combination_qty and package price
        # [ 69.64, 54.8, 53.8]
        total_array = combination_qty.map{|a1| a1.keys.map{|a1k| (result.to_h[a1k]*a1[a1k]).round(2) }.inject(:+)}

        # This is easier to test.
        # the smallest with the index [ 53.8, 2]
        # we need to determine which combination got the least
        best_combination = combination_qty[total_array.each_with_index.min.last]

        return  { :total => total_array.min, :best_combination => best_combination }

    end

end