# @author Houman Kargaran - 2017
# this module will do the dirty work for the order class. This module will act as Class Method for Order

module OrderWorker

    # Check to see if the item is valid
    #
    # @note I would have prefered this to be in the validation module.
    # @param [String] - Full user input
    # @return [Boolean]

    def is_a_valid_item_code?(order)
        result = false

        an_item = fetch_from_inventory(order)
        if an_item.size > 0
            result = true
        end

        return result
    end

    # To extract the Qty and Item Code
    #
    # @param [String] - Full user input
    # @return [Hash<String>]

    def extract_code_qty(order)
        return false if order.nil?
        order_item = order.split(' ')

        return Hash[[:qty, :code].zip order_item]
    end


    # Grab a single item from inventory
    #
    # @note It is better to cache this result as we need this over and over again
    # @param [String] - Full user input
    # @return [Array<Hash<String>>] - This is a single fully returned item

    def fetch_from_inventory(an_order)
        order = extract_code_qty(an_order)
        return Inventory.fetch_an_item(order[:code])
    end


    # Format the order output
    #
    # @param [Array<Hash>]
    # @return [String] - Output for the user

    def format_order(items)

        format_lock =  items.map do |x|

                            summery =  x.first[:summery]
                            puts "#{summery[:qty]} #{summery[:sku_number]} $#{summery[:total]}\n"

                            x.first[:line_items].each do |line_item|
                                puts "\t#{line_item[:qty]} X #{line_item[:pack]} $#{line_item[:each_pack]}\n"
                            end

                            puts '---'* 5

                        end

        return format_lock

    end

end