# @author: Houman Kargaran - 2017
# This is the bottle neck for accessing to the products. Everything must go through this
# Note: This is could implemented better. This could be a potential candidate for ( Composite )
# Note: The Composite design pattern will expose the structure to the main application and increases decoupling

require 'croissant'
require 'vegemite_scroll'
require 'blueberry_muffin'

class Inventory

    # Fetch an item upon giving it the code
    #
    # @note this can be done better so it will more lazy loading.
    # @param [String] item code
    # @return [Array<Hash>] for one product

    def self.fetch_an_item(code)
        # find the item code
        klasses = Inventory.define_inventory

        packs = []
        klasses.each do |klass|
            if klass.code.to_s == code.to_s
                packs.push klass.packs
                packs.push [ {:code => code } ]

            end
        end

        return packs.flatten
    end

    private

    # Defining an array of classes to respond to fetch an item
    #
    # @param
    # @return [Array<Klass>]

    def self.define_inventory
        [ Croissant, BlueberryMuffin, VegemiteScroll]
    end

end